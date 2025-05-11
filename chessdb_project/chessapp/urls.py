from django.urls import path
from . import views

urlpatterns = [
    path("login/", views.login_view),
    path("dashboard/<str:role>/<int:user_id>/", views.dashboard_view),
]
