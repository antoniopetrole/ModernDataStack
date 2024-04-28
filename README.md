# ModernDataStack
Implementing a OLAP use case using modern data tools

# How to run this project
It's strongly encouraged that you use some sort of python virtual environment like venv, virtualenv, or poetry to keep your dependencies isolated from the rest of your system. In my case I used the python standard library venv. 

1. Install and run Apache Airflow on your local machine. This instance of Airflow will be communicating to the rest of our services which will be hosted in Docker containers. You can follow the quick start guide found here https://airflow.apache.org/docs/apache-airflow/stable/start.html
2. From the root of this project, run `docker compose up -d` to run all of the dependent docker services. 

# To access Apache Airflow
1. Once installed, just go to localhost:8080 on your local machine

# To access the Postgres database
Make sure you have psql installed on your command line on your host machine, for OSX this can be installed using `brew install libpq`. Alternatively you can exec into the docker container and run psql from inside the container which is installed by default.

If running from your local machine, just run the following command and enter the password prompt. The password is 'password'
`psql -h 127.0.0.1 -U admin -d edw`

# To access the MySQL database
Similar to Postgres, you'll need either the mysql cli tool installed on your local host machine to access the MySQL database. You can alternatively exec into the docker container running mysql and use the command line tool there which is installed by default.

If running from your local machine, just run the following command and enter the password prompt. The password is 'password'
`mysql -h 127.0.0.1 -u root -p mysql`