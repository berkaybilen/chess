import pandas as pd
import mysql.connector
from mysql.connector import Error
import os
import sys

def test_mysql_connection(host, port, user, password):
    try:
        print(f"Testing connection to MySQL at {host}:{port}...")
        connection = mysql.connector.connect(
            host=host,
            port=port,
            user=user,
            password=password,
        )
        if connection.is_connected():
            print("Successfully connected to MySQL server")
            return True
    except Error as e:
        print(f"Failed to connect to MySQL server: {e}")
        return False
    finally:
        if 'connection' in locals() and connection.is_connected():
            connection.close()

def create_connection():
    try:
        print("Attempting to connect to MySQL database...")
        # First test server connection
        if not test_mysql_connection('localhost', 3307, 'root', 'root'):
            print("Could not connect to MySQL server. Please check if:")
            print("1. MySQL server is running")
            print("2. Port 3307 is correct")
            print("3. Username and password are correct")
            sys.exit(1)

        # Then try to connect to specific database
        connection = mysql.connector.connect(
            host='localhost',
            port=3307,
            user='root',
            password='root',
            database='chessdb'
        )
        if connection.is_connected():
            db_info = connection.get_server_info()
            print(f"Connected to MySQL Server version {db_info}")
            cursor = connection.cursor()
            cursor.execute("select database();")
            record = cursor.fetchone()
            print(f"Connected to database: {record[0]}")
            return connection
    except Error as e:
        print(f"Error connecting to database 'chessdb': {e}")
        print("Please check if:")
        print("1. Database 'chessdb' exists")
        print("2. User has access to the database")
        sys.exit(1)
    return None

def disable_constraints(connection):
    try:
        cursor = connection.cursor()
        # Disable foreign key checks
        cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
        # Disable triggers
        cursor.execute("SET TRIGGER_DISABLED = 1")
        connection.commit()
        print("Disabled foreign key checks and triggers")
    except Error as e:
        print(f"Error disabling constraints: {e}")
        sys.exit(1)
    finally:
        if cursor:
            cursor.close()

def enable_constraints(connection):
    try:
        cursor = connection.cursor()
        # Re-enable foreign key checks
        cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
        # Re-enable triggers
        cursor.execute("SET TRIGGER_DISABLED = 0")
        connection.commit()
        print("Re-enabled foreign key checks and triggers")
    except Error as e:
        print(f"Error enabling constraints: {e}")
        sys.exit(1)
    finally:
        if cursor:
            cursor.close()

def insert_data_from_csv(connection, csv_file, table_name):
    try:
        print(f"\nReading CSV file: {csv_file}")
        # Read CSV file
        df = pd.read_csv(csv_file)
        print(f"Found {len(df)} rows in {csv_file}")
        
        # Create cursor
        cursor = connection.cursor()
        
        # Prepare column names and placeholders for SQL query
        columns = ', '.join(df.columns)
        placeholders = ', '.join(['%s'] * len(df.columns))
        
        # Prepare the INSERT query
        insert_query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
        print(f"Prepared query: {insert_query}")
        
        # Convert DataFrame to list of tuples for insertion
        values = [tuple(x) for x in df.values]
        
        # Execute the query
        cursor.executemany(insert_query, values)
        connection.commit()
        
        print(f"Successfully inserted {len(values)} rows into {table_name}")
        
    except pd.errors.EmptyDataError:
        print(f"Error: {csv_file} is empty")
    except pd.errors.ParserError:
        print(f"Error: Could not parse {csv_file}. Please check the file format.")
    except Error as e:
        print(f"Error inserting data into {table_name}: {e}")
        print(f"Failed query: {insert_query}")
        print(f"First row of data: {values[0] if values else 'No data'}")
    finally:
        if cursor:
            cursor.close()

def main():
    print("Starting data insertion process...")
    
    # Create connection
    connection = create_connection()
    if not connection:
        print("Failed to create database connection. Exiting...")
        sys.exit(1)

    try:
        # Disable constraints before loading data
        disable_constraints(connection)

        # Directory containing CSV files
        csv_dir = os.path.dirname(os.path.abspath(__file__))
        print(f"Looking for CSV files in: {csv_dir}")
        
        # Dictionary mapping CSV files to table names
        file_table_mapping = {
            'Arbiters.csv': 'Arbiters',
            'ArbiterCertifications.csv': 'ArbiterCertifications',
            'Coaches.csv': 'Coaches',
            'CoachCertifications.csv': 'CoachCertifications',
            'Halls.csv': 'Hall',
            'Tables.csv': 'HallTable',
            'Matches.csv': 'Matches',
            'Players.csv': 'Players',
            'PlayerTeams.csv': 'Plays_in',
            'Sponsors.csv': 'Sponsor',
            'Teams.csv': 'Team',
            'Titles.csv': 'Title'
        }
        
        # Process each CSV file
        for csv_file, table_name in file_table_mapping.items():
            file_path = os.path.join(csv_dir, f"ChessDB_updated.xlsx - {csv_file}")
            if os.path.exists(file_path):
                print(f"\nProcessing {csv_file}...")
                insert_data_from_csv(connection, file_path, table_name)
            else:
                print(f"File not found: {file_path}")

        # Re-enable constraints after loading data
        enable_constraints(connection)

    except Error as e:
        print(f"Database error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Unexpected error: {e}")
        sys.exit(1)
    finally:
        if connection.is_connected():
            connection.close()
            print("\nMySQL connection closed")

if __name__ == "__main__":
    main() 