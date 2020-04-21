# NYCBusETL


## QUICK START (EMR)
```bash
aws emr create-cluster --name "MyCluster" --release-label emr-5.29.0 \
--applications Name=Spark --ec2-attributes KeyName=myKey --instance-type m5.xlarge --instance-count 3 \
--steps Type=CUSTOM_JAR,Name="Spark Program",Jar="command-runner.jar",ActionOnFailure=CONTINUE,Args=[spark-example,SparkPi,10] --use-default-roles

aws emr add-steps --cluster-id j-3781EMFYUCYXU --steps Type=Spark,Name="Spark Program",ActionOnFailure=CONTINUE,Args=[--class,ETL.LoadData,s3://db-task-02/jar/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar]

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