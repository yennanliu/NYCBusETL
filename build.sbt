name := "NYC_BUS_ETL"

version := "1.0"

scalaVersion := "2.11.8"

val sparkVersion = "2.3.0"

resolvers += Resolver.sonatypeRepo("snapshots")

libraryDependencies ++= Seq(
  // config
  "com.typesafe" % "config" % "1.2.1", 
  "org.apache.spark" %% "spark-core" % "2.4.3",
  "org.scalactic" %% "scalactic" % "3.1.0",
  "org.apache.spark" %% "spark-sql" % "2.4.3",
  "org.apache.spark" %% "spark-mllib" % "2.4.3" % "runtime",
  "com.databricks" %% "spark-csv" % "1.4.0",
  "com.amazonaws" % "aws-java-sdk" % "1.11.636",
  "org.apache.hadoop" % "hadoop-aws" % "2.7.6",

  // ES 
  "org.elasticsearch" % "elasticsearch-hadoop" % "7.6.1",

  // others 
  "org.apache.commons" % "commons-text" % "1.8",

  // test
  "org.scalatest" %% "scalatest" % "3.1.1" % "test"

)

conflictManager := ConflictManager.latestRevision
