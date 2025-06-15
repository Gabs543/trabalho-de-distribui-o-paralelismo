LOAD DATA CHARACTERSET AL32UTF8 
INFILE 'C:\csv/crime.csv'
BADFILE 'crime.bad'
DISCARDFILE 'crime.dsc'
APPEND
INTO TABLE C##PolRouteDS.crime
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    id,
    total_feminicide,
    total_homicide,
    total_felony_murder,
    total_bodily_harm,
    total_theft_cellphone,
    total_armed_robbery_cellphone,
    total_theft_auto,
    total_armed_robbery_auto,
    segment_id,
    time_id
)