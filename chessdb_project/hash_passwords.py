import hashlib
from chessapp.db import get_cursor

def hash_password(password):
    """Hash a password using SHA-256 to match MySQL's SHA2 function."""
    return hashlib.sha256(password.encode('utf-8')).hexdigest().lower()

def update_all_passwords():
    """Update all plaintext passwords in the database to hashed passwords."""
    with get_cursor(dictrows=True) as cur:
        # Get all users
        cur.execute("SELECT username, password FROM Users")
        users = cur.fetchall()
        
        updated_count = 0
        for user in users:
            username = user['username']
            current_password = user['password']
            
            # Check if this looks like a hash already (64 hex chars for SHA-256)
            if len(current_password) == 64 and all(c in '0123456789abcdef' for c in current_password.lower()):
                print(f"Password for {username} already appears to be hashed, skipping")
                continue
            
            # Hash the current password
            hashed_password = hash_password(current_password)
            
            # Update the user's password
            cur.execute(
                "UPDATE Users SET password = %s WHERE username = %s",
                (hashed_password, username)
            )
            updated_count += 1
            print(f"Updated password for {username}")
        
        print(f"Updated {updated_count} out of {len(users)} passwords")

if __name__ == "__main__":
    print("Starting password hash update...")
    update_all_passwords()
    print("Password update complete!") 