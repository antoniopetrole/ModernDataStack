import textwrap
from datetime import datetime, timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow.models.dag import DAG
# Operators; we need this to operate!
from airflow.operators.python import PythonOperator

##################################################
###### IMPLEMENTATION NEED TO MOVE EXTERNAL ######
# Currently keeping this here until I get a ######
# better solution for staging my external   ######
# business logic python files               ######
##################################################
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

##################################################
###### END IMPLEMENTATION                   ######
##################################################

with DAG(
    "mysql_to_postgres_etl",
    # These args will get passed on to each operator
    # You can override them on a per-task basis during operator initialization
    default_args={
        "depends_on_past": False,
        "email": ["airflow@example.com"],
        "email_on_failure": False,
        "email_on_retry": False,
        "retries": 1,
        "retry_delay": timedelta(minutes=5),
        # 'queue': 'bash_queue',
        # 'pool': 'backfill',
        # 'priority_weight': 10,
        # 'end_date': datetime(2016, 1, 1),
        # 'wait_for_downstream': False,
        # 'sla': timedelta(hours=2),
        # 'execution_timeout': timedelta(seconds=300),
        # 'on_failure_callback': some_function, # or list of functions
        # 'on_success_callback': some_other_function, # or list of functions
        # 'on_retry_callback': another_function, # or list of functions
        # 'sla_miss_callback': yet_another_function, # or list of functions
        # 'on_skipped_callback': another_function, #or list of functions
        # 'trigger_rule': 'all_success'
    },
    description="A simple DAG for extracting data from MySQL and loading it into Postgres",
    schedule=timedelta(minutes=1),
    start_date=datetime(2024, 4, 30),
    catchup=False,
    tags=["example"],
) as dag:

    table_list = ['customers','employees','offices','orderdetails','orders','payments','productlines','products']
    for table in table_list: 
        t1 = PythonOperator(task_id='transfer_table_' + table,
                                            python_callable=transfer_table,
                                            op_kwargs={'table': table},
                                            dag=dag)
        t1.doc_md = textwrap.dedent(
            """\
        #### Task Documentation
        You can document your task using the attributes `doc_md` (markdown),
        `doc` (plain text), `doc_rst`, `doc_json`, `doc_yaml` which gets
        rendered in the UI's Task Instance Details page.
        ![img](https://imgs.xkcd.com/comics/fixing_problems.png)
        **Image Credit:** Randall Munroe, [XKCD](https://xkcd.com/license.html)
        """
        )
        dag.doc_md = __doc__  # providing that you have a docstring at the beginning of the DAG; OR
        dag.doc_md = """
        This is a documentation placed anywhere
        """  # otherwise, type it like this

        t1 