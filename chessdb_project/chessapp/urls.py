from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_view, name='login'),
    path('login/', views.login_view, name='login'),
    path('dashboard/<str:role>/<int:user_id>/', views.dashboard_view, name='dashboard'),
    path('create_match/<int:user_id>/', views.create_match, name='create_match'),
    path('assign_player/<int:user_id>/<int:match_id>/', views.assign_player, name='assign_player'),
]
