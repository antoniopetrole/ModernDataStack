
##################################################
###### IMPLEMENTATION NEED TO MOVE EXTERNAL ######
# Currently keeping this here until I get a ######
# better solution for staging my external   ######
# business logic python files               ######
##################################################
import mysql.connector 
import pandas as pd
from sqlalchemy import create_engine
from datetime import datetime
from sqlalchemy.types import TEXT 
from collections import defaultdict

def transfer_table(table):
    mysqlConn = mysql.connector.connect(host="127.0.0.1",    # your host, usually localhost
                        user="root",         # your username
                        password="password",  # your password
                        database="classicmodels")        # name of the data base
    
    # always_nvarchar = defaultdict(lambda: NVARCHAR(length=255))

    cur = mysqlConn.cursor(buffered=True)

    cur.execute("SELECT * FROM " + table)

    columns = [col[0] for col in cur.description]

    df = pd.DataFrame(cur.fetchall(), columns=columns)

    dtypedict = {}
    for i,j in zip(df.columns, df.dtypes):
        dtypedict.update({i: TEXT})

    df["loaded_timestamp"] = datetime.now()
    
    engine = create_engine('postgresql://admin:password@localhost:5432/edw')
    df.to_sql(table, schema='raw', con=engine, if_exists='replace', index=False,dtype = dtypedict) 

    cur.close()
    mysqlConn.close()
    engine.dispose() 

transfer_table('customers')