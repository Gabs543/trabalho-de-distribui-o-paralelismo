LOAD DATA
INFILE 'tempo.csv'
INTO TABLE tempo
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id,
  period,
  day,
  month,
  year,
  weekday
)

LOAD DATA
INFILE 'segmento.csv'
INTO TABLE segmento
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id,
  name,
  geometry
)

LOAD DATA
INFILE 'crimes.csv'
INTO TABLE crimes
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
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

LOAD DATA
INFILE 'vertice.csv'
SKIP 1
INTO TABLE zonas
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id,
  label,
  district_id,
  neighborhood_id,
  zone_id
)