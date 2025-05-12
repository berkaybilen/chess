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

        with get_cursor(dictrows=True) as cur:
            cur.execute("SELECT * FROM Users WHERE username = %s", (username,))
            user = cur.fetchone()

        if user and user["password"] == password:
            return redirect(f"/dashboard/{user['role']}/{user['id']}")

        return render(request, "login.html", {"error": "Invalid credentials"})

    return render(request, "login.html")

def dashboard_view(request, role, user_id):
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE id = %s AND role = %s", (user_id, role))
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
                WHERE cta.coachUsername = %s
                AND CURRENT_DATE BETWEEN cta.contractStart AND cta.contractFinish
            """, (user_id,))
            coach_teams = cur.fetchall()

            # Get all teams
            cur.execute("SELECT * FROM Team")
            all_teams = cur.fetchall()

            # Get certified arbiters
            cur.execute("""
                SELECT a.*, u.username 
                FROM Arbiters a
                JOIN Users u ON a.user_id = u.id
                JOIN ArbiterCertifications ac ON a.user_id = ac.arbiter_id
            """)
            arbiters = cur.fetchall()

        context = {
            "user": user,
            "halls": halls,
            "tables": tables,
            "coach_teams": coach_teams,
            "all_teams": all_teams,
            "arbiters": arbiters
        }
        return render(request, "dashboard_coach.html", context)

    return render(request, f"dashboard_{role}.html", {"user": user})

@csrf_exempt
def create_match(request, user_id):
    if request.method != "POST":
        return JsonResponse({"error": "Method not allowed"}, status=405)
    
    # Verify if the user is a coach
    with get_cursor(dictrows=True) as cur:
        cur.execute("SELECT * FROM Users WHERE id = %s AND role = 'coach'", (user_id,))
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
        arbiter_id = int(data.get('arbiter_id'))
        
        # Basic validation
        if not all([match_date, start_slot, hall_id, table_id, team1_id, team2_id, arbiter_id]):
            return JsonResponse({"error": "Missing required fields"}, status=400)
        
        with get_cursor(dictrows=True) as cur:
            # Verify if the coach is associated with team1
            cur.execute("""
                SELECT * FROM CoachTeamAgreement 
                WHERE coachUsername = %s AND teamID = %s
                AND CURRENT_DATE BETWEEN contractStart AND contractFinish
            """, (user_id, team1_id))
            if not cur.fetchone():
                return JsonResponse({"error": "You can only create matches for your own team"}, status=403)
            
            # Insert the match - the triggers will handle the validations
            try:
                cur.execute("""
                    INSERT INTO Match 
                    (date, timeSlot, hallID, tableNo, team1ID, team2ID, assignedArbiter)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                    RETURNING matchID
                """, (match_date, start_slot, hall_id, table_id, team1_id, team2_id, arbiter_id))
                
                match_id = cur.fetchone()['matchID']
                print("it comes to create match")
                return redirect(f"/dashboard/coach/{user_id}?success=Match created successfully")
                
            except Exception as e:
                return redirect(f"/dashboard/coach/{user_id}?error={str(e)}")
                
    except Exception as e:
        return redirect(f"/dashboard/coach/{user_id}?error=Invalid data format")