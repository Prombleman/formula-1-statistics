'''
Python part 
'''

import psycopg2
from config import host, user, password,db_name

try:
    # connect to exist database
    connection = psycopg2.connect(
        host=host,
        user=user,
        password=password,
        database=db_name

    )
    # the cursor for perfoming database operations
    #cursor = connection.cursor()

    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT version();"
        )

        print(f"Server version: {cursor.fetchone()}")

    # get date from table racer
    with connection.cursor() as cursor:
        cursor.execute(
            """SELECT * FROM team;"""
        )

        print(cursor.fetchall())


except Exception as _ex:
    print("[INFO] ERROR while working whith PostgreSQL", _ex)
finally:
    if connection:
        # cursor.close()
        connection.close()
        print("[INFO] PostgreSQL connection closed")

