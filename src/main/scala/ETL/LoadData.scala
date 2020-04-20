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

//import org.apache.hadoop.conf.Configuration
//import org.apache.hadoop.fs.{ FileSystem, Path }


object LoadData { 

    def main(args: Array[String]){ 

        val sc = new SparkContext("local[*]", "LoadData")   
        val sqlContext = new org.apache.spark.sql.SQLContext(sc)
        val spark = SparkSession
            .builder
            .appName("LoadData")
            .master("local[*]")
            .config("spark.sql.warehouse.dir", "/temp") // Necessary to work around a Windows bug in Spark 2.0.0; omit if you're not on Windows.
            .getOrCreate()

        import spark.implicits._

        //Destination directory

        val srcDataFile = "data_sample"
        val destDataDirRoot =  "output"

        // load processed data

        val bus_data = spark.read
                          .option("header","true")
                          .option("delimiter", ",")
                          .csv(srcDataFile + "/" + "*.csv")

        // RDD -> spark sql table

        bus_data.createOrReplaceTempView("bus")

        // merge spark sql table
        
        val curatedDF = spark.sql("""
             SELECT * FROM bus
              """)

      curatedDF.show()

      // make duplicated columns : pickup_year, pickup_month, for preventing these columns been dropped out when "partitionby"
      //val curatedDF_ = curatedDF.withColumn("_pickup_year", $"pickup_year").withColumn("_pickup_month", $"pickup_month")

      val curatedDF_  = curatedDF

      //Save as csv, partition by year and month
      curatedDF_
          .repartition(1)  //save output in 1 csv by month by year, can do the "larger" repartition when work on the whole dataset
          .write
          .format("csv")
          .mode("append")
          .option("header","true")
          .save(destDataDirRoot)   

  }

}