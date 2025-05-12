from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from chessapp.db import get_cursor
from django.http import HttpResponse, JsonResponse
from datetime import datetime

@csrf_exempt
def login_view(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]

        contains_lower = False
        contains_upper = False
        contains_number = False
        contains_special_char = False
        for chars in password:
            if chars.islower():
                contains_lower = True
            if chars.isupper():
                contains_upper = True
            if 29<ord(chars)<40:
                contains_number = True
            if 33<=ord(chars)<=47 | 58<=ord(chars)<=64 | 91<=ord(chars)<=96 | 123<=ord(chars)<=126:
                contains_special_char = True
        
        if not (contains_lower & contains_upper & contains_number & contains_special_char & len(password)<8):
            return render(request, "login.html", {"error": "Password must contain at least 1 lowercase letter, 1 uppercase letter, 1 digit, 1 special char , and must be at least 8 character long."})


        with get_cursor(dictrows=True) as cur:
            cur.execute("SELECT * FROM Users WHERE username = %s", (username,))
            user = cur.fetchone()

        if user and user["password"] == password:
            return redirect(f"/dashboard/{user['role']}/{user['username']}")

        return render(request, "login.html", {"error": "Invalid credentials"})

    return render(request, "login.html")

def dashboard_view(request, role, username):
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE username = %s AND role = %s", (username, role))
        user = cur.fetchone()

    if not user:
        return render(request, "login.html", {"error": "Invalid access"})

    if role == 'coach':
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