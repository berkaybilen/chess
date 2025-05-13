# for authorization and authentication, 

# For example, user records in Database Manager can be used to authenticate admins.
from django.shortcuts import redirect
from functools import wraps
from chessapp.db import get_cursor

def role_required(*allowed_roles):
    def decorator(view_func):
        @wraps(view_func)
        def wrapper(request, *args, **kwargs):
            # Get user from session
            user = request.session.get("user")
            
            # If no user in session or role not allowed
            if not user or user["role"] not in allowed_roles:
                return redirect("/login")
                
            # If user exists in session, verify against database for security
            with get_cursor(dictrows=True) as cur:
                cur.execute(
                    "SELECT * FROM Users WHERE user_id = %s AND username = %s AND role = %s", 
                    (user["user_id"], user["username"], user["role"])
                )
                db_user = cur.fetchone()
            
            # If user doesn't exist in database or details don't match
            if not db_user:
                # Clear invalid session
                if 'user' in request.session:
                    del request.session['user']
                return redirect("/login")
                
            return view_func(request, *args, **kwargs)
        return wrapper
    return decorator

def get_user_info(request):
    """Get user information from session."""
    return request.session.get("user", None)

def logout_user(request):
    """Logout user by clearing session."""
    if 'user' in request.session:
        del request.session['user']
