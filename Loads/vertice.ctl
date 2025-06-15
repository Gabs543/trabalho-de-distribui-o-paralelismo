LOAD DATA CHARACTERSET AL32UTF8 
INFILE 'C:\csv/vertice.csv'
BADFILE 'vertice.bad'
DISCARDFILE 'vertice.dsc'
APPEND
INTO TABLE C##PolRouteDS.vertice
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id ,
    label,
    district_id,
    neighborhood_id,
    zone_id 
)
