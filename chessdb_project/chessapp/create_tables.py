# chessapp/create_tables.py
import os
from .db import get_cursor

SQL_DIR = os.path.join(os.path.dirname(__file__), "../sql")

def run_sql_file(path: str):
    with open(path, "r") as f:
        content = f.read()

    statements = [s.strip() for s in content.split(";") if s.strip()]
    with get_cursor() as cur:
        for stmt in statements:
            try:
                cur.execute(stmt)
            except Exception as e:
                print(f"[SQL ERROR]: {e}\n--> Statement: {stmt[:100]}...")

def run_init_db_sql():
    with get_cursor() as cur:
        cur.execute("SHOW TABLES LIKE 'Users';")
        exists = cur.fetchone()

    if exists:
        print("[ChessApp] Tables already exist. Skipping init.")
        return

    print("[ChessApp] Running DB init scripts...")
    run_sql_file(os.path.join(SQL_DIR, "create_user_tables.sql"))
    print("[ChessApp] DB Initialized.")
