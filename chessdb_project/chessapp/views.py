from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from chessapp.db import get_cursor
from chessapp.auth import role_required
from django.http import HttpResponse

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

    return render(request, f"dashboard_{role}.html", {"user": user})