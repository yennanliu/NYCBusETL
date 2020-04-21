CREATE EXTERNAL TABLE `nyc_bus_staging`(
  `recorded_year` DOUBLE, 
  `recorded_month` DOUBLE, 
  --`recorded_day` DOUBLE, 
  `recorded_hour` timestamp, 
  `recorded_minute` timestamp, 
  `recorded_second` timestamp, 
  `recorded_date` timestamp, 
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
PARTITIONED BY (recorded_day string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
)
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  --'s3://db-task-02/NYCBus/staging/_recorded_year=2017/_recorded_month=6/_recorded_day=17/'
  's3://db-task-02/NYCBus/staging/_recorded_year=2017/'
TBLPROPERTIES ('has_encrypted_data'='false')
