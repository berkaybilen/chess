from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_view, name='login'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('dashboard/<str:role>/<str:username>/', views.dashboard_view, name='dashboard'),
    path('create_match/<str:username>/', views.create_match, name='create_match'),
    path('assign_player/<str:username>/<int:match_id>/', views.assign_player, name='assign_player'),
    path('delete_match/<str:username>/<int:match_id>/', views.delete_match, name='delete_match'),
    path('add_user/<str:username>/', views.add_user, name='add_user'),
    path('rename_hall/<str:username>/', views.rename_hall, name='rename_hall'),
]
