from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_view, name='login'),
    path('login/', views.login_view, name='login'),
    path('dashboard/<str:role>/<str:username>/', views.dashboard_view, name='dashboard'),
    path('create_match/<str:username>/', views.create_match, name='create_match'),
    path('assign_player/<str:username>/<int:match_id>/', views.assign_player, name='assign_player'),
]
