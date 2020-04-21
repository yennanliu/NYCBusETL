# # 1) Create EMR and run job in client mode 
# aws emr create-cluster \
#      --name "MyclusterXX" \
#      --instance-count 3 \
#      --log-uri s3://db-task-02/emrLog \
#      --release-label emr-5.9.0 \
#      --instance-type m4.large \
#      --applications Name=Spark \
#      --steps '[{"Args":["spark-submit","--deploy-mode","client","--class","ETL.SparkHelloWorld","s3://db-task-02/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar"],"Type":"CUSTOM_JAR","ActionOnFailure":"TERMINATE_CLUSTER","Jar":"s3://db-task-02/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar"}]'\
#      --use-default-roles \
#      --auto-terminate

# 2) Create EMR and run job in cluster mode 
aws emr create-cluster \
     --name "MyclusterXX" \
     --instance-count 3 \
     --log-uri s3://db-task-02/emrLog \
     --release-label emr-5.9.0 \
     --instance-type m4.large \
     --applications Name=Spark \
     --steps '[{"Args":["spark-submit","--deploy-mode","cluster","--class","ETL.SparkHelloWorld","--driver-class-path","s3://db-task-02/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar","s3://db-task-02/target/scala-2.11/nyc_bus_etl_2.11-1.0.jar"],"Type":"CUSTOM_JAR","ActionOnFailure":"TERMINATE_CLUSTER","Jar":"command-runner.jar"}]' \
     --use-default-roles \
     --auto-terminate