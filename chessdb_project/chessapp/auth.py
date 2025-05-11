# for authorization and authentication, 

# For example, user records in Database Manager can be used to authenticate admins.
from django.shortcuts import redirect
from functools import wraps

def role_required(*allowed_roles):
    def decorator(view_func):
        @wraps(view_func)
        def wrapper(request, *args, **kwargs):
            user = request.session.get("user")
            if not user or user["role"] not in allowed_roles:
                return redirect("/login")
            return view_func(request, *args, **kwargs)
        return wrapper
    return decorator
