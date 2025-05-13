#!/usr/bin/env python
"""
Setup script for the Chess Database project.
This will install dependencies and set up the database.
"""
import os
import sys
import subprocess
import time

def install_dependencies():
    print("Installing dependencies...")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
        print("Dependencies installed successfully.")
    except subprocess.CalledProcessError:
        print("Failed to install dependencies. Please check the requirements.txt file.")
        sys.exit(1)

def setup_django_db():
    print("Setting up Django database...")
    try:
        # Make migrations
        subprocess.check_call([sys.executable, "chessdb_project/manage.py", "makemigrations"])
        # Apply migrations
        subprocess.check_call([sys.executable, "chessdb_project/manage.py", "migrate"])
        print("Django database set up successfully.")
    except subprocess.CalledProcessError:
        print("Failed to set up Django database. Please check your database configuration.")
        sys.exit(1)

def run_setup_scripts():
    print("Running setup scripts...")
    try:
        # Run session setup script
        subprocess.check_call([sys.executable, "chessdb_project/setup_sessions.py"])
        print("Setup scripts executed successfully.")
    except subprocess.CalledProcessError:
        print("Failed to execute setup scripts.")
        sys.exit(1)

def main():
    print("=== Chess Database Project Setup ===")
    
    # Step 1: Install dependencies
    install_dependencies()
    
    # Step 2: Setup Django database
    setup_django_db()
    
    # Step 3: Run setup scripts
    run_setup_scripts()
    
    print("\nSetup completed successfully!")
    print("To run the server: python chessdb_project/manage.py runserver")

if __name__ == "__main__":
    main() 