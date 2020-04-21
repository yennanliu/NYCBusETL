package ETL

import org.apache.spark.sql.DataFrame
import org.apache.log4j.Logger
import org.apache.log4j.Level
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types.{StructType, StructField, StringType, IntegerType,LongType,FloatType,DoubleType, TimestampType}
import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import java.util.Calendar

import org.apache.hadoop.fs.{ FileSystem, Path }
import org.apache.hadoop.conf.Configuration


object TransformRecordByBusLine { 

    def main(args: Array[String]){ 

      val sc = new SparkContext("local[*]", "SaveMaterializedviewToHive")   
      val sqlContext = new org.apache.spark.sql.SQLContext(sc)
      val spark = SparkSession
        .builder
        .appName("SaveMaterializedviewToHive")
        .master("local[*]")
        .config("spark.sql.warehouse.dir", "/temp") // Necessary to work around a Windows bug in Spark 2.0.0; omit if you're not on Windows.
        .config("spark.network.timeout", "6000s") // https://stackoverflow.com/questions/48219169/3600-seconds-timeout-that-spark-worker-communicating-with-spark-driver-in-heartb
        .config("spark.executor.heartbeatInterval", "10000s")
        .config("spark.executor.memory", "10g")
        .enableHiveSupport()
        .getOrCreate()

        import spark.implicits._

        //Destination directory

        var srcDataFile = "s3://db-task-02/NYCBus/staging"
        val destDataDirRoot =  "s3://db-task-02/NYCBus/master"

        val bus_data = spark.read
                          .option("header","true")
                          .option("delimiter", ",")
                          .csv(srcDataFile + "/*/*/*/" +  "*.csv")

        bus_data.createOrReplaceTempView("bus")
        
        val curatedDF = spark.sql("""
            SELECT * 
              FROM  
            bus """)

      curatedDF.show()

      val curatedDF_ = curatedDF.withColumn("_PublishedLineName", $"PublishedLineName")

      curatedDF_
          .repartition(1)  //save output in 1 csv by month by year, can do the "larger" repartition when work on the whole dataset
          .write
          .format("csv")
          .mode("append")
          .option("header","true")
          .partitionBy("_PublishedLineName")
          .save(destDataDirRoot)   
  }

}