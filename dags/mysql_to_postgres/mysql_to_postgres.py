import mysql.connector 
import pandas as pd
from sqlalchemy import create_engine

def transfer_table(table):
    mysqlConn = mysql.connector.connect(host="127.0.0.1",    # your host, usually localhost
                        user="root",         # your username
                        password="password",  # your password
                        database="classicmodels")        # name of the data base

    cur = mysqlConn.cursor(buffered=True)

    cur.execute("SELECT * FROM " + table)

    df = pd.DataFrame(cur.fetchall())

    engine = create_engine('postgresql://admin:password@localhost:5432/edw')
    df.to_sql(table, con=engine, if_exists='replace', index=False) 

    cur.close()
    mysqlConn.close()
    engine.dispose()