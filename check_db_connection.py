#!/usr/bin/env python
"""
Script to verify MySQL database connection.
"""
import mysql.connector

def check_connection():
    try:
        print("Attempting to connect to MySQL database...")
        cnx = mysql.connector.connect(
            host="127.0.0.1",
            user="chessuser",
            password="chesspass",
            database="chessdb",
            port=3307,
        )
        
        cursor = cnx.cursor()
        cursor.execute("SELECT 1")
        result = cursor.fetchone()
        
        if result and result[0] == 1:
            print("✅ Connection successful!")
            
            # Check if Users table exists
            try:
                cursor.execute("SELECT COUNT(*) FROM Users")
                count = cursor.fetchone()[0]
                print(f"✅ Users table exists with {count} records")
            except mysql.connector.Error as err:
                print(f"❌ Error accessing Users table: {err}")
                
        cursor.close()
        cnx.close()
        
    except mysql.connector.Error as err:
        print(f"❌ Connection failed: {err}")
        
        if err.errno == 2003:
            print("\nTroubleshooting tips:")
            print("1. Make sure MySQL server is running")
            print("2. Check if MySQL is listening on port 3307")
            print("3. Verify firewall settings allow connections to MySQL")
        elif err.errno == 1045:
            print("\nTroubleshooting tips:")
            print("1. Check if username 'chessuser' exists")
            print("2. Verify the password is correct")
            print("3. Make sure the user has proper privileges")
        elif err.errno == 1049:
            print("\nTroubleshooting tips:")
            print("1. Create database 'chessdb' if it doesn't exist")
            print("2. Make sure the user has access to the database")
    
    except Exception as e:
        print(f"❌ Unexpected error: {e}")

if __name__ == "__main__":
    check_connection() 