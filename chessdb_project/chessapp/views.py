from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from chessapp.db import get_cursor
from django.http import HttpResponse, JsonResponse
from datetime import datetime
import hashlib
import re
from chessapp.auth import get_user_info, logout_user, role_required

def hash_password(password):
    """Hash a password using SHA-256 to match MySQL's SHA2 function."""
    return hashlib.sha256(password.encode('utf-8')).hexdigest().lower()

@csrf_exempt
def login_view(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]

        # Get user from database
        with get_cursor(dictrows=True) as cur:
            cur.execute("SELECT * FROM Users WHERE username = %s", (username,))
            user = cur.fetchone()
        
        if user:
            # Hash the input password
            hashed_password = hash_password(password)
            
            # Check if the hashed password matches the stored hash
            if hashed_password == user["password"] or password == user["password"]:
                # Store user info in session
                request.session['user'] = {
                    'id': user['id'],  # Changed from user_id to id
                    'username': user['username'],
                    'role': user['role']
                }
                return redirect(f"/dashboard/{user['role']}/{user['username']}")
        
        return render(request, "login.html", {"error": "Invalid credentials"})

    return render(request, "login.html")

def logout_view(request):
    """Logout user and redirect to login page."""
    logout_user(request)
    return redirect('/login')

@role_required('manager', 'player', 'coach', 'arbiter')
def dashboard_view(request, role, username):
    # Get user from session
    user_session = get_user_info(request)
    
    # Verify if the authenticated user matches the requested dashboard
    if not user_session or user_session['username'] != username or user_session['role'] != role:
        # Clear invalid session access
        if 'user' in request.session:
            del request.session['user_id']
        return redirect("/login")

    # Get user details from database
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE username = %s AND role = %s", (username, role))
        user = cur.fetchone()

    if not user:
        return redirect("/login")

    if role == 'manager':
        with get_cursor(dictrows=True) as cur:
            # Get halls for renaming
            cur.execute("SELECT * FROM Hall")
            halls = cur.fetchall()
            
            # Get certifications for arbiters
            cur.execute("SELECT * FROM Certification WHERE id IN (SELECT certification_id FROM CertificationArbiter)")
            arbiter_certifications = cur.fetchall()
            
            # Get certifications for coaches
            cur.execute("SELECT * FROM Certification WHERE id IN (SELECT certification_id FROM CertificationCoach)")
            coach_certifications = cur.fetchall()
        
        return render(request, "dashboard_manager.html", {
            "user": user, 
            "halls": halls,
            "arbiter_certifications": arbiter_certifications,
            "coach_certifications": coach_certifications
        })
    elif role == 'coach':
        with get_cursor(dictrows=True) as cur:
            # Get halls
            cur.execute("SELECT * FROM Hall")
            halls = cur.fetchall()

            # Get all tables from all halls
            cur.execute("SELECT * FROM HallTable ORDER BY hall_id, table_no")
            tables = cur.fetchall()

            # Get teams coached by this user
            cur.execute("""
                SELECT * FROM Team t
                JOIN CoachTeamAgreement cta ON t.id = cta.team_id
                WHERE cta.coach_user_id = %s
                AND CURRENT_DATE BETWEEN cta.contract_start AND cta.contract_finish
            """, (user['id'],))  # Changed to use id instead of username
            coach_teams = cur.fetchall()
            
            # Get all teams
            cur.execute("SELECT * FROM Team")
            all_teams = cur.fetchall()

            all_teams = [team for team in all_teams if team['id'] not in [t['id'] for t in coach_teams]]

            # Get certified arbiters
            cur.execute("""
                SELECT a.*, u.username 
                FROM Arbiters a
                JOIN Users u ON a.id = u.id
                JOIN CertificationArbiter ac ON a.id = ac.arbiter_id
            """)
            arbiters = cur.fetchall()

            cur.execute("""
                SELECT 
                    m.*,
                    h.name as hallName,
                    t1.name as team_white,
                    t2.name as team_black,
                    CONCAT(a.name, ' ', a.surname) as arbiterName,
                    CASE 
                        WHEN m.team_white IN (
                            SELECT team_id FROM CoachTeamAgreement 
                            WHERE coach_user_id = %s 
                            AND CURRENT_DATE BETWEEN contract_start AND contract_finish
                        ) THEN true
                        ELSE false
                    END as is_coach_team1,
                    wp.name as white_player_name,
                    bp.name as black_player_name
                FROM Matches m
                JOIN Hall h ON m.hall_id = h.id
                JOIN Team t1 ON m.team_white = t1.id
                JOIN Team t2 ON m.team_black = t2.id
                JOIN Arbiters a ON m.arbiter_user_id = a.id
                LEFT JOIN MatchResults mr ON m.id = mr.id
                LEFT JOIN Players wp ON mr.white_player_id = wp.id
                LEFT JOIN Players bp ON mr.black_player_id = bp.id
                WHERE m.team_white IN (
                    SELECT team_id FROM CoachTeamAgreement 
                    WHERE coach_user_id = %s 
                    AND CURRENT_DATE BETWEEN contract_start AND contract_finish
                )
                OR m.team_black IN (
                    SELECT team_id FROM CoachTeamAgreement 
                    WHERE coach_user_id = %s 
                    AND CURRENT_DATE BETWEEN contract_start AND contract_finish
                )
                ORDER BY m.date, m.time_slot
            """, (user['id'], user['id'], user['id']))
            team_matches = cur.fetchall()

            # Get available players from coach's teams
            cur.execute("""
                SELECT p.* 
                FROM Players p
                JOIN Plays_in pi ON p.id = pi.player_user_id
                JOIN Team t ON pi.team_id = t.id
                JOIN CoachTeamAgreement cta ON t.id = cta.team_id
                WHERE cta.coach_user_id = %s
                AND CURRENT_DATE BETWEEN cta.contract_start AND cta.contract_finish
            """, (user['id'],))
            team_players = cur.fetchall()

        context = {
            "user": user,
            "halls": halls,
            "tables": tables,
            "coach_teams": coach_teams,
            "all_teams": all_teams,
            "arbiters": arbiters,
            "team_matches": team_matches,
            "team_players": team_players
        }
        return render(request, "dashboard_coach.html", context)

    return render(request, f"dashboard_{role}.html", {"user": user})

@csrf_exempt
@role_required('coach')
def assign_player(request, username, match_id):
    if request.method != "POST":
        return JsonResponse({"error": "Method not allowed"}, status=405)
    
    # Verify if the user is a coach
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE username = %s AND role = 'coach'", (username,))
        coach = cur.fetchone()
        
    if not coach:
        return JsonResponse({"error": "Unauthorized access"}, status=401)
    
    try:
        player_username = request.POST.get('player_username')
        if not player_username:
            return redirect(f"/dashboard/coach/{username}?error=Player not selected")
        
        with get_cursor(dictrows=True) as cur:
            # Get the player's ID
            cur.execute("SELECT id FROM Players WHERE username = %s", (player_username,))
            player_data = cur.fetchone()
            if not player_data:
                return redirect(f"/dashboard/coach/{username}?error=Player not found")
            
            player_id = player_data['id']
            
            # Verify if the match exists and coach has rights to assign
            cur.execute("""
                SELECT m.*, 
                    CASE 
                        WHEN m.team_white IN (
                            SELECT team_id FROM CoachTeamAgreement 
                            WHERE coach_user_id = %s 
                            AND CURRENT_DATE BETWEEN contract_start AND contract_finish
                        ) THEN 'white'
                        WHEN m.team_black IN (
                            SELECT team_id FROM CoachTeamAgreement 
                            WHERE coach_user_id = %s 
                            AND CURRENT_DATE BETWEEN contract_start AND contract_finish
                        ) THEN 'black'
                        ELSE 'none'
                    END as coach_team_side
                FROM Matches m
                WHERE m.id = %s
            """, (coach['id'], coach['id'], match_id))
            match = cur.fetchone()
            
            if not match:
                return redirect(f"/dashboard/coach/{username}?error=Match not found")
            
            # Debug information
            print(f"Match ID: {match_id}, Player ID: {player_id}")
            print(f"Coach team side: {match['coach_team_side']}")
            
            if match['coach_team_side'] == 'none':
                return redirect(f"/dashboard/coach/{username}?error=You don't coach either team in this match")
            
            # Check if player is in the coach's team
            team_id = match['team_white'] if match['coach_team_side'] == 'white' else match['team_black']
            cur.execute("""
                SELECT 1 FROM Plays_in
                WHERE player_user_id = %s AND team_id = %s
            """, (player_id, team_id))
            if not cur.fetchone():
                return redirect(f"/dashboard/coach/{username}?error=Player not in your team")
            
            # Check if a match result entry exists
            cur.execute("SELECT * FROM MatchResults WHERE id = %s", (match_id,))
            match_result = cur.fetchone()
            
            # Determine which field to update based on coach's team side
            player_field = 'white_player_id' if match['coach_team_side'] == 'white' else 'black_player_id'
            
            if match_result:
                # Update existing match result with appropriate player field
                cur.execute(f"""
                    UPDATE MatchResults 
                    SET {player_field} = %s
                    WHERE id = %s
                """, (player_id, match_id))
            else:
                # Create new match result with appropriate player field
                if match['coach_team_side'] == 'white':
                    cur.execute("""
                        INSERT INTO MatchResults (id, white_player_id, black_player_id, result)
                        VALUES (%s, %s, NULL, NULL)
                    """, (match_id, player_id))
                else:
                    cur.execute("""
                        INSERT INTO MatchResults (id, white_player_id, black_player_id, result)
                        VALUES (%s, NULL, %s, NULL)
                    """, (match_id, player_id))
            
            return redirect(f"/dashboard/coach/{username}?success=Player assigned successfully")
            
    except Exception as e:
        print(f"Error assigning player: {str(e)}")
        return redirect(f"/dashboard/coach/{username}?error={str(e)}")

@csrf_exempt
@role_required('coach')
def create_match(request, username):
    if request.method != "POST":
        return JsonResponse({"error": "Method not allowed"}, status=405)
    
    # Verify if the user is a coach
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE username = %s AND role = 'coach'", (username,))
        coach = cur.fetchone()
        
    if not coach:
        return JsonResponse({"error": "Unauthorized access"}, status=401)
    
    try:
        data = request.POST
        match_date = data.get('date')
        start_slot = int(data.get('start_slot'))
        hall_id = int(data.get('hall_id'))
        table_id = int(data.get('table_id'))
        team1_id = int(data.get('team1_id'))
        team2_id = int(data.get('team2_id'))
        arbiter_username = data.get('arbiter_username')
        
        # Basic validation
        if not all([match_date, start_slot, hall_id, table_id, team1_id, team2_id, arbiter_username]):
            return JsonResponse({"error": "Missing required fields"}, status=400)
        
        # Calculate the end slot (each match takes 2 time slots)
        end_slot = start_slot + 1
        
        if start_slot > 6:  # If starting at slot 7, it would end at slot 8, which is invalid
            return redirect(f"/dashboard/coach/{username}?error=Invalid time slot. Matches require 2 consecutive slots.")
        
        with get_cursor(dictrows=True) as cur:
            # Check if hall_id and table_no combination exists
            cur.execute("""
                SELECT * FROM HallTable 
                WHERE hall_id = %s AND table_no = %s
            """, (hall_id, table_id))
            hall_table = cur.fetchone()
            
            if not hall_table:
                return redirect(f"/dashboard/coach/{username}?error=Invalid hall and table combination")
            
            # Validate that teams are different
            if team1_id == team2_id:
                return redirect(f"/dashboard/coach/{username}?error=Teams cannot play against themselves")
            
            # Check for table availability - ensure no matches overlap with this table on the given date/time slots
            cur.execute("""
                SELECT * FROM Matches
                WHERE hall_id = %s AND table_no = %s AND date = %s
                AND (
                    (time_slot <= %s AND time_slot + 1 >= %s) OR  -- Existing match overlaps with start_slot
                    (time_slot <= %s AND time_slot + 1 >= %s)     -- Existing match overlaps with end_slot
                )
            """, (hall_id, table_id, match_date, start_slot, start_slot, end_slot, end_slot))
            
            overlapping_table_matches = cur.fetchall()
            if overlapping_table_matches:
                return redirect(f"/dashboard/coach/{username}?error=The selected table is not available at this time")
            
            # Check if arbiter is available (not assigned to another match at the same time)
            cur.execute("SELECT id FROM Arbiters WHERE username = %s", (arbiter_username,))
            arbiter_data = cur.fetchone()
            if not arbiter_data:
                return redirect(f"/dashboard/coach/{username}?error=Arbiter not found")
                
            arbiter_id = arbiter_data['id']
            
            cur.execute("""
                SELECT * FROM Matches
                WHERE arbiter_user_id = %s AND date = %s
                AND (
                    (time_slot <= %s AND time_slot + 1 >= %s) OR  -- Existing match overlaps with start_slot
                    (time_slot <= %s AND time_slot + 1 >= %s)     -- Existing match overlaps with end_slot
                )
            """, (arbiter_id, match_date, start_slot, start_slot, end_slot, end_slot))
            
            overlapping_arbiter_matches = cur.fetchall()
            if overlapping_arbiter_matches:
                return redirect(f"/dashboard/coach/{username}?error=The selected arbiter is already assigned to another match at this time")
            
            # Check if either team is already scheduled for another match at the same time
            cur.execute("""
                SELECT * FROM Matches
                WHERE date = %s
                AND (
                    (time_slot <= %s AND time_slot + 1 >= %s) OR  -- Existing match overlaps with start_slot
                    (time_slot <= %s AND time_slot + 1 >= %s)     -- Existing match overlaps with end_slot
                )
                AND (team_white = %s OR team_white = %s OR team_black = %s OR team_black = %s)
            """, (match_date, start_slot, start_slot, end_slot, end_slot, team1_id, team2_id, team1_id, team2_id))
            
            overlapping_team_matches = cur.fetchall()
            if overlapping_team_matches:
                return redirect(f"/dashboard/coach/{username}?error=One or both teams are already scheduled for another match at this time")
            
            # Verify if the coach is associated with team1
            cur.execute("""
                SELECT * FROM CoachTeamAgreement 
                WHERE coach_user_id = %s AND team_id = %s
                AND CURRENT_DATE BETWEEN contract_start AND contract_finish
            """, (coach['id'], team1_id))
            if not cur.fetchone():
                return JsonResponse({"error": "You can only create matches for your own team"}, status=403)
            
            # All validations passed, insert the match
            cur.execute("""
                INSERT INTO Matches 
                (date, time_slot, hall_id, table_no, team_white, team_black, arbiter_user_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (match_date, start_slot, hall_id, table_id, team1_id, team2_id, arbiter_id))
            
            match_id = cur.lastrowid
            return redirect(f"/dashboard/coach/{username}?success=Match created successfully")
                
    except Exception as e:
        return redirect(f"/dashboard/coach/{username}?error=Error creating match: {str(e)}")

@csrf_exempt
@role_required('coach')
def delete_match(request, username, match_id):
    if request.method != "POST":
        return JsonResponse({"error": "Method not allowed"}, status=405)
    
    # Verify if the user is a coach
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE username = %s AND role = 'coach'", (username,))
        coach = cur.fetchone()
        
    if not coach:
        return JsonResponse({"error": "Unauthorized access"}, status=401)
    
    try:
        with get_cursor(dictrows=True) as cur:
            # Check if the match exists and belongs to a team coached by this coach (either white or black team)
            cur.execute("""
                SELECT m.* FROM Matches m
                WHERE m.id = %s 
                AND (
                    m.team_white IN (
                        SELECT team_id FROM CoachTeamAgreement 
                        WHERE coach_user_id = %s 
                        AND CURRENT_DATE BETWEEN contract_start AND contract_finish
                    )
                    OR
                    m.team_black IN (
                        SELECT team_id FROM CoachTeamAgreement 
                        WHERE coach_user_id = %s 
                        AND CURRENT_DATE BETWEEN contract_start AND contract_finish
                    )
                )
            """, (match_id, coach['id'], coach['id']))
            
            match = cur.fetchone()
            
            if not match:
                return redirect(f"/dashboard/coach/{username}?error=You can only delete matches for teams you coach")
            
            # Begin transaction
            cur.execute("START TRANSACTION")
            
            # Delete any match results first (cascading deletion)
            cur.execute("DELETE FROM MatchResults WHERE id = %s", (match_id,))
            
            # Delete the match itself
            cur.execute("DELETE FROM Matches WHERE id = %s", (match_id,))
            
            # Commit the transaction
            cur.execute("COMMIT")
            
            # Redirect to the main coach dashboard with success message
            return redirect(f"/dashboard/coach/{username}?success=Match successfully deleted")
            
    except Exception as e:
        # If anything goes wrong, rollback
        with get_cursor() as cur:
            cur.execute("ROLLBACK")
        
        print(f"Error deleting match: {str(e)}")
        return redirect(f"/dashboard/coach/{username}?error={str(e)}")

@csrf_exempt
@role_required('manager')
def add_user(request, username):
    # Verify if the user is a manager
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE username = %s AND role = 'manager'", (username,))
        manager = cur.fetchone()
        
    if not manager:
        return JsonResponse({"error": "Unauthorized access"}, status=401)
    
    if request.method == "POST":
        try:
            # Get form data
            new_username = request.POST.get('username')
            password = request.POST.get('password')
            role = request.POST.get('role')
            
            # Validate password
            if not validate_password(password):
                return redirect(f"/dashboard/manager/{username}?error=Password must contain at least 8 characters, include uppercase, lowercase, digit, and special character")
            
            # Hash password consistently
            hashed_password = hash_password(password)
            
            with get_cursor(dictrows=True) as cur:
                # Check if username exists
                cur.execute("SELECT * FROM Users WHERE username = %s", (new_username,))
                if cur.fetchone():
                    return redirect(f"/dashboard/manager/{username}?error=Username already exists")
                
                # Insert user
                cur.execute("""
                    INSERT INTO Users (username, password, role) 
                    VALUES (%s, %s, %s)
                """, (new_username, hashed_password, role))
                
                # Get the newly created user_id
                cur.execute("SELECT id FROM Users WHERE username = %s", (new_username,))
                user_id = cur.fetchone()['id']
                
                # Add role-specific information
                if role == 'player':
                    name = request.POST.get('name')
                    surname = request.POST.get('surname')
                    elo_rating = request.POST.get('elo_rating', 1200)
                    title = request.POST.get('title')
                    nationality = request.POST.get('nationality')
                    date_of_birth = request.POST.get('date_of_birth')
                    fide_id = request.POST.get('fide_id')
                    
                    # Validate required fields
                    if not all([title, nationality, date_of_birth, fide_id]):
                        # Delete the user if validation fails
                        cur.execute("DELETE FROM Users WHERE id = %s", (user_id,))
                        return redirect(f"/dashboard/manager/{username}?error=All player fields are required")
                    
                    # Get title_id from title name
                    cur.execute("SELECT id FROM Title WHERE name = %s", (title,))
                    title_result = cur.fetchone()
                    if not title_result:
                        # Delete the user if title not found
                        cur.execute("DELETE FROM Users WHERE id = %s", (user_id,))
                        return redirect(f"/dashboard/manager/{username}?error=Invalid title selected")
                    
                    title_id = title_result['id']
                    
                    cur.execute("""
                        INSERT INTO Players (id, username, name, surname, elo_rating, title_id, nationality, date_of_birth, fide_id) 
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """, (user_id, new_username, name, surname, elo_rating, title_id, nationality, date_of_birth, fide_id))
                    
                elif role == 'coach':
                    name = request.POST.get('coach_name')
                    surname = request.POST.get('coach_surname')
                    nationality = request.POST.get('coach_nationality')
                    certification_name = request.POST.get('coach_certification')
                    
                    # Validate required fields
                    if not all([name, surname, nationality, certification_name]):
                        # Delete the user if validation fails
                        cur.execute("DELETE FROM Users WHERE id = %s", (user_id,))
                        return redirect(f"/dashboard/manager/{username}?error=All coach fields are required")
                    
                    # Get certification_id from the certification name
                    cur.execute("SELECT id FROM Certification WHERE name = %s", (certification_name,))
                    certification_result = cur.fetchone()
                    if not certification_result:
                        # If certification doesn't exist, create it
                        cur.execute("""
                            INSERT INTO Certification (name)
                            VALUES (%s)
                        """, (certification_name,))
                        
                        cur.execute("SELECT id FROM Certification WHERE name = %s", (certification_name,))
                        certification_result = cur.fetchone()
                    
                    certification_id = certification_result['id']
                    
                    cur.execute("""
                        INSERT INTO Coaches (id, username, name, surname, nationality) 
                        VALUES (%s, %s, %s, %s, %s)
                    """, (user_id, new_username, name, surname, nationality))
                    
                    # Insert into CertificationCoach table
                    cur.execute("""
                        INSERT INTO CertificationCoach (coach_id, certification_id) 
                        VALUES (%s, %s)
                    """, (user_id, certification_id))
                    
                elif role == 'arbiter':
                    name = request.POST.get('arbiter_name')
                    surname = request.POST.get('arbiter_surname')
                    nationality = request.POST.get('arbiter_nationality')
                    certification_id = request.POST.get('certification_id')
                    experience_level = request.POST.get('arbiter_experience_level')
                    
                    # Validate required fields
                    if not all([name, surname, nationality, experience_level]):
                        # Delete the user if validation fails
                        cur.execute("DELETE FROM Users WHERE id = %s", (user_id,))
                        return redirect(f"/dashboard/manager/{username}?error=All arbiter fields are required")
                    
                    cur.execute("""
                        INSERT INTO Arbiters (id, username, name, surname, nationality, experience_level) 
                        VALUES (%s, %s, %s, %s, %s, %s)
                    """, (user_id, new_username, name, surname, nationality, experience_level))
                    
                    if certification_id:
                        cur.execute("""
                            INSERT INTO CertificationArbiter (arbiter_id, certification_id) 
                            VALUES (%s, %s)
                        """, (user_id, certification_id))
            
            return redirect(f"/dashboard/manager/{username}?success=User {new_username} created successfully")
                
        except Exception as e:
            return redirect(f"/dashboard/manager/{username}?error={str(e)}")
    
    return redirect(f"/dashboard/manager/{username}")

@csrf_exempt
@role_required('manager')
def rename_hall(request, username):
    # Verify if the user is a manager
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE username = %s AND role = 'manager'", (username,))
        manager = cur.fetchone()
        
    if not manager:
        return JsonResponse({"error": "Unauthorized access"}, status=401)
    
    if request.method == "POST":
        try:
            hall_id = request.POST.get('hall_id')
            new_hall_name = request.POST.get('new_hall_name')
            
            if not hall_id or not new_hall_name:
                return redirect(f"/dashboard/manager/{username}?error=Missing hall ID or new name")
            
            with get_cursor(dictrows=True) as cur:
                cur.execute("""
                    UPDATE Hall
                    SET name = %s
                    WHERE id = %s
                """, (new_hall_name, hall_id))
                
                return redirect(f"/dashboard/manager/{username}?success=Hall renamed successfully")
                
        except Exception as e:
            return redirect(f"/dashboard/manager/{username}?error={str(e)}")
    
    return redirect(f"/dashboard/manager/{username}")

def validate_password(password):
    """Validate password according to requirements."""
    if len(password) < 8:
        return False
    
    # Check for at least one lowercase letter
    if not re.search(r'[a-z]', password):
        return False
    
    # Check for at least one uppercase letter
    if not re.search(r'[A-Z]', password):
        return False
    
    # Check for at least one digit
    if not re.search(r'\d', password):
        return False
    
    # Check for at least one special character
    if not re.search(r'[!@#$%^&*(),.?":{}|<>]', password):
        return False
    
    return True

def hash_password_view(request):
    """Temporary view to generate hash for a password."""
    if request.method == "GET":
        password = request.GET.get('password')
        if password:
            hashed = hash_password(password)
            return HttpResponse(f"Original: {password}<br>Hashed: {hashed}")
        return HttpResponse("""
            <form method="GET">
                <input type="text" name="password">
                <button type="submit">Hash</button>
            </form>
        """)