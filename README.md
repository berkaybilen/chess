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
- MySQL Server
- pip (Python package manager)

### Setup Steps

1. **Install Python Dependencies**
   ```bash
   cd db_record
   pip install -r requirements.txt
   ```

2. **Database Configuration**
   - Make sure MySQL server is running
   - Create a database named 'chessdb'
   - Update database connection settings in `db_record/insert_data.py` if needed:
     ```python
     connection = mysql.connector.connect(
         host='localhost',
         user='root',
         password='root',
         database='chessdb'
     )
     ```

3. **Run SQL Scripts**
   Execute the SQL scripts in the following order:
   ```bash
   mysql -u root -p chessdb < sql/01_create_user_table.sql
   mysql -u root -p chessdb < sql/02_create_team_table.sql
   mysql -u root -p chessdb < sql/03_create_tournament_table.sql
   mysql -u root -p chessdb < sql/04_create_match_table.sql
   mysql -u root -p chessdb < sql/04_triggers.sql
   ```

4. **Insert Initial Data**
   Run the Python script to insert data from CSV files:
   ```bash
   cd db_record
   python insert_data.py
   ```
   
   Note: The script will automatically:
   - Disable foreign key checks and triggers before loading data
   - Load all data from CSV files
   - Re-enable foreign key checks and triggers after loading
   
   This allows the initial dataset to be loaded even if it contains intentionally invalid records.

### Data Files
The CSV files in the `db_record` directory follow this naming convention:
- Prefix: "ChessDB_updated.xlsx - "
- Suffix: Table name + ".csv"

Example: "ChessDB_updated.xlsx - Players.csv" corresponds to the Players table.

### Important Note About Data Integrity
- The initial dataset may contain intentionally invalid records (e.g., matches with players outside of contract)
- These records are preserved as-is for testing purposes
- After initial data load, all constraints and triggers are re-enabled
- Future operations will be subject to all data integrity rules
- The system ensures no new invalid records can be inserted while preserving existing data

### Troubleshooting
- If you encounter any errors during data insertion, check:
  1. Database connection settings
  2. CSV file format and content
  3. Table structure matches CSV columns
  4. Foreign key constraints are satisfied

### Note
The data insertion script processes files in a specific order to maintain referential integrity. If you need to reinsert data, you may need to:
1. Drop all tables
2. Recreate tables using SQL scripts
3. Run the insertion script again