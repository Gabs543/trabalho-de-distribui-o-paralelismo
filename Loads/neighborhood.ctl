LOAD DATA CHARACTERSET AL32UTF8
INFILE 'C:\csv/neighborhood.csv'
BADFILE 'neighborhood.bad'
DISCARDFILE 'neighborhood.dsc'
APPEND
INTO TABLE C##PolRouteDS.neighborhood
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id ,
    name char(256),
    geom char(1000000)
)