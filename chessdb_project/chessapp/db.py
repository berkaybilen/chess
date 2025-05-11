
import os
import mysql.connector
from contextlib import contextmanager

@contextmanager
def get_cursor(dictrows=False):
    """Context manager to yield a MySQL cursor and handle connection lifecycle.
    Args:
        dictrows (bool): If True, cursor returns rows as dictionaries. Defaults to False.
        
    Usage:
    In a method or function using the following will help to use SQL queries:   
        with get_cursor(dictrows=True) as cur:
            cur.execute("SELECT * FROM ..")
            return cur.fetchall()
    """
    cnx = mysql.connector.connect(
        host="127.0.0.1",
        user="chessuser",
        password="chesspass",
        database="chessdb",
        autocommit=True,
        port = 3307,
    )
    try:
        cursor = cnx.cursor(dictionary=dictrows)
        yield cursor
    finally:
        cursor.close()
        cnx.close()
