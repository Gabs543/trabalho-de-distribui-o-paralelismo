LOAD DATA CHARACTERSET AL32UTF8
INFILE 'C:\csv/district.csv'
BADFILE 'district.bad'
DISCARDFILE 'district.dsc'
APPEND
INTO TABLE C##PolRouteDS.district
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id ,
    name char(256),
    geom char(1000000)
)
