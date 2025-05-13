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
            if hashed_password == user["password"]:
                # Store user info in session
                request.session['user'] = {
                    'user_id': user['user_id'],
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
            del request.session['user']
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
        
        return render(request, "dashboard_manager.html", {"user": user, "halls": halls})
    elif role == 'coach':
        with get_cursor(dictrows=True) as cur:
            # Get halls
            cur.execute("SELECT * FROM Hall")
            halls = cur.fetchall()

            # Get tables
            cur.execute("SELECT * FROM HallTable")
            tables = cur.fetchall()

            # Get teams coached by this user
            cur.execute("""
                SELECT t.* FROM Team t
                JOIN CoachTeamAgreement cta ON t.teamID = cta.teamID
                WHERE cta.coach_username = %s
                AND CURRENT_DATE BETWEEN cta.contractStart AND cta.contractFinish
            """, (username,))
            coach_teams = cur.fetchall()

            # Get all teams
            cur.execute("SELECT * FROM Team")
            all_teams = cur.fetchall()

            # Get certified arbiters
            cur.execute("""
                SELECT a.*, u.username 
                FROM Arbiters a
                JOIN Users u ON a.username = u.username
                JOIN ArbiterCertifications ac ON a.username = ac.arbiter_username
            """)
            arbiters = cur.fetchall()

            # Get team matches and player assignments
            cur.execute("""
                SELECT 
                    m.*,
                    h.hallName,
                    t1.teamName as team1Name,
                    t2.teamName as team2Name,
                    CONCAT(a.name, ' ', a.surname) as arbiterName,
                    CASE 
                        WHEN m.team1ID IN (
                            SELECT teamID FROM CoachTeamAgreement 
                            WHERE coach_username = %s 
                            AND CURRENT_DATE BETWEEN contractStart AND contractFinish
                        ) THEN true
                        ELSE false
                    END as is_coach_team1,
                    wp.name as white_player_name,
                    bp.name as black_player_name
                FROM Matches m
                JOIN Hall h ON m.hallID = h.hallID
                JOIN Team t1 ON m.team1ID = t1.teamID
                JOIN Team t2 ON m.team2ID = t2.teamID
                JOIN Arbiters a ON m.arbiter_username = a.username
                LEFT JOIN Players wp ON m.whitePlayerUsername = wp.username
                LEFT JOIN Players bp ON m.blackPlayerUsername = bp.username
                WHERE m.team1ID IN (
                    SELECT teamID FROM CoachTeamAgreement 
                    WHERE coach_username = %s 
                    AND CURRENT_DATE BETWEEN contractStart AND contractFinish
                )
                OR m.team2ID IN (
                    SELECT teamID FROM CoachTeamAgreement 
                    WHERE coach_username = %s 
                    AND CURRENT_DATE BETWEEN contractStart AND contractFinish
                )
                ORDER BY m.date, m.timeSlot
            """, (username, username, username))
            team_matches = cur.fetchall()

            # Get available players from coach's teams
            cur.execute("""
                SELECT p.* 
                FROM Players p
                JOIN Plays_in pi ON p.username = pi.player_username
                JOIN Team t ON pi.teamID = t.teamID
                JOIN CoachTeamAgreement cta ON t.teamID = cta.teamID
                WHERE cta.coach_username = %s
                AND CURRENT_DATE BETWEEN cta.contractStart AND cta.contractFinish
            """, (username,))
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
            # Verify if the match exists and coach has rights to assign
            cur.execute("""
                SELECT m.*, 
                    CASE 
                        WHEN m.team1ID IN (
                            SELECT teamID FROM CoachTeamAgreement 
                            WHERE coach_username = %s 
                            AND CURRENT_DATE BETWEEN contractStart AND contractFinish
                        ) THEN true
                        ELSE false
                    END as is_coach_team1
                FROM Matches m
                WHERE m.matchID = %s
            """, (username, match_id))
            match = cur.fetchone()
            
            if not match:
                return redirect(f"/dashboard/coach/{username}?error=Match not found")
            
            # Verify player belongs to the correct team
            team_id = match['team1ID'] if match['is_coach_team1'] else match['team2ID']
            cur.execute("""
                SELECT 1 FROM Plays_in
                WHERE player_username = %s AND teamID = %s
            """, (player_username, team_id))
            if not cur.fetchone():
                return redirect(f"/dashboard/coach/{username}?error=Player not in your team")
            
            # Update the match with the player assignment
            player_field = 'whitePlayerUsername' if match['is_coach_team1'] else 'blackPlayerUsername'
            cur.execute(f"""
                UPDATE Matches 
                SET {player_field} = %s
                WHERE matchID = %s
                AND {player_field} IS NULL
            """, (player_username, match_id))
            
            return redirect(f"/dashboard/coach/{username}?success=Player assigned successfully")
            
    except Exception as e:
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
        
        with get_cursor(dictrows=True) as cur:
            # Verify if the coach is associated with team1
            cur.execute("""
                SELECT * FROM CoachTeamAgreement 
                WHERE coach_username = %s AND teamID = %s
                AND CURRENT_DATE BETWEEN contractStart AND contractFinish
            """, (username, team1_id))
            if not cur.fetchone():
                return JsonResponse({"error": "You can only create matches for your own team"}, status=403)
            
            # Insert the match - the triggers will handle the validations
            try:
                cur.execute("""
                    INSERT INTO Matches 
                    (date, timeSlot, hallID, tableNo, team1ID, team2ID, arbiter_username)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                    RETURNING matchID
                """, (match_date, start_slot, hall_id, table_id, team1_id, team2_id, arbiter_username))
                
                match_id = cur.fetchone()['matchID']
                return redirect(f"/dashboard/coach/{username}?success=Match created successfully")
                
            except Exception as e:
                return redirect(f"/dashboard/coach/{username}?error={str(e)}")
                
    except Exception as e:
        return redirect(f"/dashboard/coach/{username}?error=Invalid data format")

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
                cur.execute("SELECT user_id FROM Users WHERE username = %s", (new_username,))
                user_id = cur.fetchone()['user_id']
                
                # Add role-specific information
                if role == 'player':
                    name = request.POST.get('name')
                    surname = request.POST.get('surname')
                    elo_rating = request.POST.get('elo_rating', 1200)
                    
                    cur.execute("""
                        INSERT INTO Players (user_id, username, name, surname, elo_rating) 
                        VALUES (%s, %s, %s, %s, %s)
                    """, (user_id, new_username, name, surname, elo_rating))
                    
                elif role == 'coach':
                    name = request.POST.get('coach_name')
                    surname = request.POST.get('coach_surname')
                    
                    cur.execute("""
                        INSERT INTO Coaches (user_id, username, name, surname) 
                        VALUES (%s, %s, %s, %s)
                    """, (user_id, new_username, name, surname))
                    
                elif role == 'arbiter':
                    name = request.POST.get('arbiter_name')
                    surname = request.POST.get('arbiter_surname')
                    certification_id = request.POST.get('certification_id')
                    
                    cur.execute("""
                        INSERT INTO Arbiters (user_id, username, name, surname) 
                        VALUES (%s, %s, %s, %s)
                    """, (user_id, new_username, name, surname))
                    
                    if certification_id:
                        cur.execute("""
                            INSERT INTO ArbiterCertifications (arbiter_user_id, certification_id) 
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
                    SET hallName = %s
                    WHERE hallID = %s
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