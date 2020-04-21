# NYCBusETL
> Process NYC bus open data via Spark running on AWS EMR
- Steps:
    - Load data
    - Transform data
    - Save data
- Techs : Spark, EMR, Athena, Scala
- ETL : [etl_script](https://github.com/yennanliu/NYCBusETL/tree/master/src/main/scala/ETL)
- Data : [S3_data](https://console.aws.amazon.com/s3/buckets/db-task-02/NYCBus/?region=ap-southeast-2&tab=overview)

## QUICK START (EMR)
```bash
# create emr cluster
aws emr create-cluster \
    --name "MyClusterX" \
    --instance-type m3.xlarge \
    --release-label emr-4.1.0 \
    --instance-count 1 \
    --use-default-roles \
    --applications Name=Spark \
    --log-uri "s3n://db-task-02/emr_log/"

# add spark job as emr step
bash
aws emr add-steps --cluster-id j-3EP8DZHCQQJDS \
--steps Type=Spark,Name="Spark Program",ActionOnFailure=TERMINATE_CLUSTER,Args=[--class,ETL.LoadData,s3://db-task-02/jar/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar]

bash
aws emr add-steps --cluster-id j-3RJLR2UZT5NSF \
--steps Type=Spark,Name="Spark Program",ActionOnFailure=TERMINATE_CLUSTER,Args=[--class,ETL.TransformRecordByBusLine,s3://db-task-02/jar/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar]

```

## QUICK START  (local)
```bash
sbt clean compile

sbt package 
# run LoadData job 
spark-submit \
 --class ETL.LoadData \
 target/scala-2.11/nyc_bus_etl_2.11-1.0.jar

 spark-submit \
 --class ETL.SparkHelloWorld \
 target/scala-2.11/nyc_bus_etl_2.11-1.0.jar

```