#!/usr/bin/env python
"""
This script will run the Django migrations to ensure the session tables are created.
"""
import os
import sys
import django

def setup_django_sessions():
    # Setup Django environment
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'chessdb_project.settings')
    django.setup()
    
    # Run migrations for the sessions app
    from django.core.management import call_command
    print("Running migrations for Django sessions...")
    call_command('migrate', 'sessions')
    print("Session tables created successfully.")

if __name__ == "__main__":
    setup_django_sessions() 