FROM ${AIRFLOW_IMAGE_NAME:-apache/airflow:2.9.1}
USER airflow
RUN pip install apache-airflow-providers-airbyte[http] \
&& pip install apache-airflow-providers-airbyte

