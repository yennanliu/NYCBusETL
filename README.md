# NYCBusETL

## QUICK START 
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