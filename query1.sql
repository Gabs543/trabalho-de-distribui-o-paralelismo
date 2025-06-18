alter session set current_schema = C##PolRouteDS; 

/* QUERY 1*/
SELECT 
    c.segment_id,
    SUM(c.total_feminicide) AS feminicide,
    SUM(c.total_homicide) AS homicide,
    SUM(c.total_felony_murder) AS felony_murder,
    SUM(c.total_bodily_harm) AS bodily_harm,
    SUM(c.total_theft_cellphone) AS theft_cellphone,
    SUM(c.total_armed_robbery_cellphone) AS robbery_cellphone,
    SUM(c.total_theft_auto) AS theft_auto,
    SUM(c.total_armed_robbery_auto) AS robbery_auto
FROM 
    crime c
JOIN segment s ON c.segment_id = s.id
JOIN vertice v1 ON s.start_vertice_id = v1.id
JOIN vertice v2 ON s.final_vertice_id = v2.id
JOIN district d1 ON v1.district_id = d1.id
JOIN district d2 ON v2.district_id = d2.id
JOIN data_time t ON c.time_id = t.id
WHERE 
    t.year = 2016
    AND ('GRAJAU' IN (d1.name, d2.name))
GROUP BY 
    c.segment_id;

SELECT /*+ PARALLEL(c 4) PARALLEL(s 4) PARALLEL(v1 4) PARALLEL(v2 4) PARALLEL(d1 4) PARALLEL(d2 4) */
    c.segment_id,
    SUM(c.total_feminicide) AS feminicide,
    SUM(c.total_homicide) AS homicide,
    SUM(c.total_felony_murder) AS felony_murder,
    SUM(c.total_bodily_harm) AS bodily_harm,
    SUM(c.total_theft_cellphone) AS theft_cellphone,
    SUM(c.total_armed_robbery_cellphone) AS robbery_cellphone,
    SUM(c.total_theft_auto) AS theft_auto,
    SUM(c.total_armed_robbery_auto) AS robbery_auto
FROM 
    crime c
JOIN segment s ON c.segment_id = s.id
JOIN vertice v1 ON s.start_vertice_id = v1.id
JOIN vertice v2 ON s.final_vertice_id = v2.id
JOIN district d1 ON v1.district_id = d1.id
JOIN district d2 ON v2.district_id = d2.id
JOIN data_time t ON c.time_id = t.id
WHERE 
    t.year = 2016
    AND ('IGUATEMI' IN (d1.name, d2.name))
GROUP BY 
    c.segment_id;

/* Query 2*/

SELECT 
    c.segment_id,
    SUM(c.total_feminicide) AS feminicide,
    SUM(c.total_homicide) AS homicide,
    SUM(c.total_felony_murder) AS felony_murder,
    SUM(c.total_bodily_harm) AS bodily_harm,
    SUM(c.total_theft_cellphone) AS theft_cellphone,
    SUM(c.total_armed_robbery_cellphone) AS robbery_cellphone,
    SUM(c.total_theft_auto) AS theft_auto,
    SUM(c.total_armed_robbery_auto) AS robbery_auto
FROM 
    crime c
JOIN segment s ON c.segment_id = s.id
JOIN vertice v1 ON s.start_vertice_id = v1.id
JOIN vertice v2 ON s.final_vertice_id = v2.id
JOIN district d1 ON v1.district_id = d1.id
JOIN district d2 ON v2.district_id = d2.id
JOIN data_time t ON c.time_id = t.id
WHERE 
    t.year BETWEEN 2006 AND 2016
    AND ('IGUATEMI' IN (d1.name, d2.name))
GROUP BY 
    c.segment_id;

SELECT /*+ PARALLEL(c 4) PARALLEL(s 4) PARALLEL(v1 4) PARALLEL(v2 4) PARALLEL(d1 4) PARALLEL(d2 4) */
    c.segment_id,
    SUM(c.total_feminicide) AS feminicide,
    SUM(c.total_homicide) AS homicide,
    SUM(c.total_felony_murder) AS felony_murder,
    SUM(c.total_bodily_harm) AS bodily_harm,
    SUM(c.total_theft_cellphone) AS theft_cellphone,
    SUM(c.total_armed_robbery_cellphone) AS robbery_cellphone,
    SUM(c.total_theft_auto) AS theft_auto,
    SUM(c.total_armed_robbery_auto) AS robbery_auto
FROM 
    crime c
JOIN segment s ON c.segment_id = s.id
JOIN vertice v1 ON s.start_vertice_id = v1.id
JOIN vertice v2 ON s.final_vertice_id = v2.id
JOIN district d1 ON v1.district_id = d1.id
JOIN district d2 ON v2.district_id = d2.id
JOIN data_time t ON c.time_id = t.id
WHERE 
    t.year BETWEEN 2006 AND 2016
    AND ('IGUATEMI' IN (d1.name, d2.name))
GROUP BY 
    c.segment_id;


/* Query 3*/

/* Query 4*/
/* Query 5*/
/* Query 6*/
/* Query 7*/
