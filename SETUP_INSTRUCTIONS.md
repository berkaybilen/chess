# Chess Database Project - Setup Instructions

## Overview
This document provides instructions for setting up the Chess Database project, specifically focusing on the login functionality and database configuration.

## Prerequisites
- Python 3.7 or higher
- MySQL server (running on port 3307)
- MySQL database named 'chessdb' with user 'chessuser' and password 'chesspass'

## Installation Steps

### 1. Install Dependencies
Run the following command to install all required dependencies:
```
pip install -r requirements.txt
```

This will install Django, mysql-connector-python, and other necessary packages.

### 2. Database Configuration
The project has been configured to connect to a MySQL database with the following settings:
- Database name: chessdb
- Username: chessuser
- Password: chesspass
- Host: 127.0.0.1
- Port: 3307

Ensure your MySQL server is running and accessible with these credentials.

### 3. Database Driver
The project uses `mysql-connector-python` as the database driver instead of `mysqlclient`. This should work better on Windows systems without requiring C++ build tools.

### 4. Set up Django Session Tables
Run the setup_sessions.py script to create the session tables required by Django:
```
python chessdb_project/setup_sessions.py
```

### 5. Run the Application
Start the Django development server:
```
python chessdb_project/manage.py runserver
```

## Important Notes

### Existing Data
- The database includes some intentionally invalid records that should be preserved as is.
- Do not attempt to "clean" or fix existing records - they are provided on purpose.

### Password Policy
The application enforces a strict password policy for new users only:
- Minimum length: 8 characters
- Must include at least one uppercase letter [A-Z]
- Must include at least one lowercase letter [a-z]
- Must include at least one digit [0-9]
- Must include at least one special character (e.g., @, #, $, %, etc.)

All passwords are stored as SHA-256 hashes in the database.

### Roles and Access
The application supports role-based access with four roles:
- manager: Database managers with administrative privileges
- player: Chess players
- coach: Team coaches
- arbiter: Match arbiters

Each role has access to different functionality within the application.

## Automated Setup
For convenience, you can use the setup.py script to automate the installation process:
```
python setup.py
```

This script will install dependencies, set up the database, and configure the sessions. 