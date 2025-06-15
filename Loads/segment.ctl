LOAD DATA CHARACTERSET AL32UTF8 
INFILE 'C:\csv/segment.csv'
BADFILE 'segment.bad'
DISCARDFILE 'segment.dsc'
APPEND
INTO TABLE C##PolRouteDS.segment
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id ,
    geom char(1000),
    oneway,
    length,
    final_vertice_id,
    start_vertice_id
)