LOAD DATA CHARACTERSET AL32UTF8 
INFILE 'C:\csv/time.csv'
BADFILE 'data_time.bad'
DISCARDFILE 'data_time.dsc'
APPEND
INTO TABLE C##PolRouteDS.data_time
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id,
    period char(20),
    day,
    month,
    year,
    weekday char(10)
)