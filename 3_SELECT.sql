alter session set current_schema = C##PolRouteDS; 


SELECT
  v.district_id,
  d.name AS distrito,
  c.segment_id,
  SUM(c.total_feminicide) AS feminicidio,
  SUM(c.total_homicide) AS homicidio,
  SUM(c.total_felony_murder) AS latrocinio,
  SUM(c.total_bodily_harm) AS lesao_corporal,
  SUM(c.total_theft_cellphone + c.total_armed_robbery_cellphone) AS roubo_celular,
  SUM(c.total_theft_auto + c.total_armed_robbery_auto) AS roubo_carro
FROM crime c
JOIN data_time t ON c.time_id = t.id
JOIN segment s ON c.segment_id = s.id
JOIN vertice v ON s.start_vertice_id = v.id
JOIN district d ON v.district_id = d.id
WHERE d.name = 'IGUATEMI'
  AND t.year = 2016
GROUP BY v.district_id, d.name, c.segment_id
ORDER BY c.segment_id;

SELECT 
  v.district_id,
  d.name AS distrito,
  c.segment_id,
  SUM(c.total_feminicide) AS feminicidio,
  SUM(c.total_homicide) AS homicidio,
  SUM(c.total_felony_murder) AS latrocinio,
  SUM(c.total_bodily_harm) AS lesao_corporal,
  SUM(c.total_theft_cellphone + c.total_armed_robbery_cellphone) AS roubo_celular,
  SUM(c.total_theft_auto + c.total_armed_robbery_auto) AS roubo_carro
FROM crime c
JOIN data_time t ON c.time_id = t.id
JOIN segment s ON c.segment_id = s.id
JOIN vertice v ON s.start_vertice_id = v.id
JOIN district d ON v.district_id = d.id
WHERE d.name = 'IGUATEMI'
  AND t.year BETWEEN 2006 AND 2016
GROUP BY v.district_id, d.name, c.segment_id
ORDER BY c.segment_id;

SELECT 
  n.name AS bairro,
  SUM(c.total_theft_cellphone + c.total_armed_robbery_cellphone) AS total_roubo_celular,
  SUM(c.total_theft_auto + c.total_armed_robbery_auto) AS total_roubo_carro
FROM crime c
JOIN data_time t ON c.time_id = t.id
JOIN segment s ON c.segment_id = s.id
JOIN vertice v ON s.start_vertice_id = v.id
JOIN neighborhood n ON v.neighborhood_id = n.id
WHERE n.name = 'SANTA EFIGÊNIA'
  AND t.year = 2015
GROUP BY n.name;

SELECT 
  SUM(c.total_feminicide) AS feminicidio,
  SUM(c.total_homicide) AS homicidio,
  SUM(c.total_felony_murder) AS latrocinio,
  SUM(c.total_bodily_harm) AS lesao_corporal,
  SUM(c.total_theft_cellphone + c.total_armed_robbery_cellphone) AS roubo_celular,
  SUM(c.total_theft_auto + c.total_armed_robbery_auto) AS roubo_carro
FROM crime c
JOIN data_time t ON c.time_id = t.id
JOIN segment s ON c.segment_id = s.id
WHERE s.oneway = 1
  AND t.year = 2012;

SELECT 
  SUM(c.total_theft_cellphone + c.total_armed_robbery_cellphone) AS total_roubo_celular,
  SUM(c.total_theft_auto + c.total_armed_robbery_auto) AS total_roubo_carro
FROM crime c
JOIN data_time t ON c.time_id = t.id
WHERE t.year = 2017;

WITH soma_crimes AS (
  SELECT 
    c.segment_id,
    SUM(
      c.total_feminicide + c.total_homicide + c.total_felony_murder +
      c.total_bodily_harm + c.total_theft_cellphone + c.total_armed_robbery_cellphone +
      c.total_theft_auto + c.total_armed_robbery_auto
    ) AS total_crimes
  FROM crime c
  JOIN data_time t ON c.time_id = t.id
  WHERE t.year = 2010 AND t.month = 11
  GROUP BY c.segment_id
)
SELECT segment_id
FROM soma_crimes
WHERE total_crimes = (SELECT MAX(total_crimes) FROM soma_crimes);

WITH soma_crimes_fds AS (
  SELECT 
    c.segment_id,
    SUM(
      c.total_feminicide + c.total_homicide + c.total_felony_murder +
      c.total_bodily_harm + c.total_theft_cellphone + c.total_armed_robbery_cellphone +
      c.total_theft_auto + c.total_armed_robbery_auto
    ) AS total_crimes
  FROM crime c
  JOIN data_time t ON c.time_id = t.id
  WHERE t.year = 2018 AND t.weekday IN ('Saturday', 'Sunday')
  GROUP BY c.segment_id
)
SELECT segment_id
FROM soma_crimes_fds
WHERE total_crimes = (SELECT MAX(total_crimes) FROM soma_crimes_fds);
