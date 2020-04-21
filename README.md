# NYCBusETL


## QUICK START (EMR)
```bash
# create emr cluster
aws emr create-cluster \
    --name "MyCluster" \
    --instance-type m3.xlarge \
    --release-label emr-4.1.0 \
    --instance-count 1 \
    --use-default-roles \
    --applications Name=Spark 

# add spark job as emr step
bash
aws emr add-steps --cluster-id j-3RJLR2UZT5NSF \
--steps Type=Spark,Name="Spark Program",ActionOnFailure=CONTINUE,Args=[--class,ETL.LoadData,s3://db-task-02/jar/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar]

bash
aws emr add-steps --cluster-id j-3RJLR2UZT5NSF \
--steps Type=Spark,Name="Spark Program",ActionOnFailure=CONTINUE,Args=[--class,ETL.TransformRecordByBusLine,s3://db-task-02/jar/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar]


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