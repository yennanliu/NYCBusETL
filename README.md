# NYCBusETL
> Process NYC bus open data via Spark running on AWS EMR
- Steps:
    - [Load data](https://github.com/yennanliu/NYCBusETL/blob/master/src/main/scala/ETL/LoadData.scala)
    - [Transform & Save data](https://github.com/yennanliu/NYCBusETL/blob/master/src/main/scala/ETL/TransformRecordByBusLine.scala)
- Techs : Spark, EMR, Athena, Scala, Hive
- ETL : [etl_script](https://github.com/yennanliu/NYCBusETL/tree/master/src/main/scala/ETL)
- Data : [S3_data](https://console.aws.amazon.com/s3/buckets/db-task-02/NYCBus/?region=ap-southeast-2&tab=overview)

## Architecture
```
S3 -> EMR -> S3, Athena  -> RDS (mysql/postgre..) -> BI/reporting
```
- S3 as `data lake`, storage all raw data
- EMR as computing cluster, process/clean/load staging data from/back to S3
- Athena as quick data access tool,create table/view on all steps data
- RDS as DB save final master data (final schema) for reporting, downstream data tasks
- TODO : Use `airflow` as job scheduling, trigger period spark job (running on EMR)
- TODO : Use `AWS Lambda` as job API, to trigger period spark by
HTTP request 

## QUICK START (EMR)
```bash
# set up aws creds
aws configure

# sync jar to s3
aws s3 sync target/ s3://db-task-02/target

# create emr cluster and run job
bash script/run_job.sh

# # create emr cluster
# aws emr create-cluster \
#     --name "MyClusterX" \
#     --instance-type m3.xlarge \
#     --release-label emr-4.1.0 \
#     --instance-count 1 \
#     --use-default-roles \
#     --applications Name=Spark \
#     --log-uri "s3n://db-task-02/emr_log/"

# # add spark job as emr step
# bash
# aws emr add-steps --cluster-id j-3EP8DZHCQQJDS \
# --steps Type=Spark,Name="Spark Program",ActionOnFailure=TERMINATE_CLUSTER,Args=[--class,ETL.LoadData,s3://db-task-02/jar/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar]

# bash
# aws emr add-steps --cluster-id j-3RJLR2UZT5NSF \
# --steps Type=Spark,Name="Spark Program",ActionOnFailure=TERMINATE_CLUSTER,Args=[--class,ETL.TransformRecordByBusLine,s3://db-task-02/jar/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar]

```

## QUICK START  (local)
```bash
sbt clean compile

sbt package 

# run test job
 spark-submit \
 --class ETL.SparkHelloWorld \
 target/scala-2.11/nyc_bus_etl_2.11-1.0.jar

# run LoadData job 
spark-submit \
 --class ETL.LoadData \
 target/scala-2.11/nyc_bus_etl_2.11-1.0.jar

# run TransformRecordByBusLine job 
spark-submit \
 --class ETL.TransformRecordByBusLine \
 target/scala-2.11/nyc_bus_etl_2.11-1.0.jar


```

## Ref
- https://medium.com/big-data-on-amazon-elastic-mapreduce/run-a-spark-job-within-amazon-emr-in-15-minutes-68b02af1ae16
