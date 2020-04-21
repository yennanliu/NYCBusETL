CREATE EXTERNAL TABLE `nyc_bus_raw`(
  `recordedattime` string, 
  `directionref` string, 
  `publishedlinename` string, 
  `originname` string, 
  `originlat` string, 
  `originlong` string, 
  `destinationname` string, 
  `destinationlat` string, 
  `destinationlong` string, 
  `vehicleref` string, 
  `vehiclelocation.longitude` string, 
  `nextstoppointname` string, 
  `arrivalproximitytext` string, 
  `distancefromstop` string, 
  `expectedarrivaltime` string, 
  `scheduledarrivaltime` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY ',' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://db-task-02/NYCBus/raw'
TBLPROPERTIES ('has_encrypted_data'='false')