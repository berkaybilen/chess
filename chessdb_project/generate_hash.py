import hashlib
import sys

def hash_password(password):
    """Hash a password using SHA-256."""
    return hashlib.sha256(password.encode('utf-8')).hexdigest()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        password = sys.argv[1]
    else:
        password = input("Enter password to hash: ")
    
    hashed = hash_password(password)
    print(f"\nOriginal password: {password}")
    print(f"Hashed password:   {hashed}")
    print("\nFor MySQL insertion:")
    print(f"INSERT INTO Users (username, password, role) VALUES ('your_username', '{hashed}', 'your_role');") 