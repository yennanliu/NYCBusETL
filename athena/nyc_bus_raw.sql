CREATE EXTERNAL TABLE `nyc_bus_raw`(
  `recordedattime` timestamp, 
  `directionref` string, 
  `publishedlinename` string, 
  `originname` string, 
  `originlat` DOUBLE, 
  `originlong` DOUBLE, 
  `destinationname` string, 
  `destinationlat` DOUBLE, 
  `destinationlong` DOUBLE, 
  `vehicleref` string, 
  `vehiclelocation.latitude` string, 
  `vehiclelocation.longitude` string, 
  `nextstoppointname` string, 
  `arrivalproximitytext` string, 
  `distancefromstop` string, 
  `expectedarrivaltime` DOUBLE, 
  `scheduledarrivaltime` timestamp)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://db-task-02/NYCBus/raw'
TBLPROPERTIES ('has_encrypted_data'='false')
