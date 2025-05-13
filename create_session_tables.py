#!/usr/bin/env python
"""
Script to create Django session tables.
This will try Django migrations first and fall back to direct SQL if needed.
"""
import os
import sys
import subprocess
import mysql.connector

def run_django_migrations():
    """Attempt to run Django migrations for sessions."""
    try:
        print("Attempting to run Django migrations...")
        os.environ.setdefault("DJANGO_SETTINGS_MODULE", "chessdb_project.settings")
        
        # Change directory to where manage.py is
        original_dir = os.getcwd()
        try:
            if not os.path.exists("chessdb_project/manage.py"):
                if os.path.exists("manage.py"):
                    project_dir = "."
                else:
                    project_dir = "chessdb_project"
            else:
                project_dir = "chessdb_project"
                
            if project_dir != ".":
                os.chdir(project_dir)
            
            # Try running migrations
            result = subprocess.run(
                [sys.executable, "manage.py", "migrate", "sessions"],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                print("✅ Django migrations successful!")
                print(result.stdout)
                return True
            else:
                print("❌ Django migrations failed:")
                print(result.stderr)
                return False
                
        finally:
            os.chdir(original_dir)
    
    except Exception as e:
        print(f"❌ Error running Django migrations: {e}")
        return False

def create_tables_directly():
    """Create session tables directly with SQL if migrations failed."""
    try:
        print("\nAttempting to create session tables directly with SQL...")
        
        # Read SQL script
        with open("create_session_table.sql", "r") as f:
            sql_script = f.read()
            
        # Connect to database
        cnx = mysql.connector.connect(
            host="127.0.0.1",
            user="chessuser",
            password="chesspass",
            database="chessdb",
            port=3307,
        )
        
        cursor = cnx.cursor()
        
        # Execute each statement in the script
        statements = sql_script.split(';')
        for statement in statements:
            if statement.strip():
                cursor.execute(statement)
                
        cnx.commit()
        cursor.close()
        cnx.close()
        
        print("✅ Session tables created successfully with direct SQL!")
        return True
        
    except Exception as e:
        print(f"❌ Error creating tables directly: {e}")
        return False

def main():
    print("=== Creating Django Session Tables ===")
    
    # Try migrations first
    if run_django_migrations():
        print("\n✅ Session tables are now ready to use!")
        return
        
    # If migrations fail, try direct SQL
    print("\nFalling back to direct SQL method...")
    if create_tables_directly():
        print("\n✅ Session tables are now ready to use!")
    else:
        print("\n❌ Failed to create session tables.")
        print("Please check your database connection and try again.")

if __name__ == "__main__":
    main() 