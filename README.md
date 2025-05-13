# Chess Database Application

## Quick Start

1. Verify your database connection:
   ```
   python check_db_connection.py
   ```

2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

3. Run Django migrations:
   ```
   cd chessdb_project
   python manage.py migrate
   ```

4. Start the server:
   ```
   python manage.py runserver
   ```

5. Access the application at http://127.0.0.1:8000/

## Detailed Setup Instructions

See [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md) for complete setup instructions and troubleshooting.

## Features

- User authentication with SHA-256 password hashing
- Role-based access control (manager, player, coach, arbiter)
- Secure password policy for new users
- Session management

## Database

The application uses MySQL with the mysql-connector-python driver, configured to connect to a MySQL server on port 3307.

## 🔧 1. Clone the Repository

```bash
git clone https://github.com/your-username/chessdb.git
cd chessdb
```

## Set up virtual environment

#### Windows
```bash
python -m venv venv
venv\Scripts\activate
```

#### macOS/Linux
```bash
python3 -m venv venv
source venv/bin/activate
```

## Install Dependencies

```bash
pip install -r requirements.txt
```
## Run the Database using Docker

```bash
docker-compose up -d
```

This spins up a MySQL 8.0 server at:

Host: 127.0.0.1

Port: 3307

DB: chessdb

User: chessuser

Password: chesspass

## Create the DB Tables

In Django, iteracting with DB using admin functions (ready()) is not recommended. Instead, we will use the command line to create the tables. [ref](https://stackoverflow.com/questions/57369950/how-to-call-a-function-before-a-django-app-start/57369989#57369989:~:text=AppConfig.ready()%20docs,in%20your%20ready()%20implementation.)

So docker-compose will create the DB and then tables for us.


Note that if this does not work do the following:
1. connect to the DB using the following command in terminal:
```
mysql -h 127.0.0.1 -P 3307 -u chessuser -p
```
2. Directly run the SQL commands in the files to create the tables.




## Run the Application In Venv Terminal

```bash
python manage.py runserver
```

Now you can access the application at `http://127.0.0.1:8000/`

Also you can test DB connection using the following command:

```bash
mysql -h 127.0.0.1 -P 3307 -u chessuser -p
```

Enter the password `chesspass` when prompted.

# Chess Tournament Database

## Database Setup and Data Insertion

### Prerequisites
- Python 3.8 or higher
- MySQL Server (accessible via localhost:3307)
- MySQL command-line client (for alternative import method)
- pip (Python package manager)

### Setup Steps

1. **Install Python Dependencies**
   ```bash
   cd db_record
   pip install pandas mysql-connector-python
   ```

2. **Database Configuration**
   - Make sure MySQL server is running
   - Create a database named 'chessdb'
   ```bash
   mysql -h localhost -P 3307 -u root -p -e "CREATE DATABASE IF NOT EXISTS chessdb;"
   ```

3. **Run SQL Scripts**
   Execute the SQL scripts in the following order:
   ```bash
   mysql -h localhost -P 3307 -u root -p chessdb < sql/01_create_user_table.sql
   mysql -h localhost -P 3307 -u root -p chessdb < sql/02_create_team_table.sql
   mysql -h localhost -P 3307 -u root -p chessdb < sql/03_create_tournament_table.sql
   mysql -h localhost -P 3307 -u root -p chessdb < sql/04_create_match_table.sql
   mysql -h localhost -P 3307 -u root -p chessdb < sql/04_triggers.sql
   ```

4. **Import Data**
   You have two options for importing data:

   **Option 1: Using Python connector** (if having issues, try Option 2)
   ```bash
   cd db_record
   python insert_data.py
   ```

   **Option 2: Using MySQL CLI** (recommended if Option 1 fails)
   ```bash
   cd db_record
   python import_csv.py
   ```

### Important Note About Data Integrity
- The initial dataset may contain intentionally invalid records (e.g., matches with players outside of contract)
- These records are preserved as-is for testing purposes
- Both import scripts disable foreign key checks during data load
- After initial data load, all constraints are re-enabled
- Future operations will be subject to all data integrity rules
- The system ensures no new invalid records can be inserted while preserving existing data

### Troubleshooting

#### Option 1 Hangs or Fails
If `insert_data.py` hangs:
1. Check MySQL connection settings
2. Ensure port 3307 is correct for your MySQL instance
3. Try Option 2 using `import_csv.py` which uses the MySQL command-line client

#### Option 2 Errors
If `import_csv.py` fails:
1. Make sure MySQL command-line client is installed and available in your PATH
2. Check that you can connect manually: `mysql -h localhost -P 3307 -u root -p`
3. Verify the database exists: `mysql -h localhost -P 3307 -u root -p -e "SHOW DATABASES;"`

#### CSV Format Issues
- If you see errors about CSV format or values:
  1. Open the CSV file to check for special characters
  2. Verify the column names in the CSV match the table column names
  3. Check data types (dates should be in YYYY-MM-DD format)

### Data Files
The CSV files in the `db_record` directory follow this naming convention:
- Prefix: "ChessDB_updated.xlsx - "
- Suffix: Table name + ".csv"

Example: "ChessDB_updated.xlsx - Players.csv" corresponds to the Players table.