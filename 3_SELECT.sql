alter session set current_schema = C##PolRouteDS; 

WITH CrimeDataUnpivoted AS (
    SELECT segment_id, time_id, 'Feminicídio' AS crime_type, total_feminicide AS total_count FROM crime WHERE total_feminicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Homicídio Doloso' AS crime_type, total_homicide AS total_count FROM crime WHERE total_homicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Latrocínio' AS crime_type, total_felony_murder AS total_count FROM crime WHERE total_felony_murder > 0
    UNION ALL
    SELECT segment_id, time_id, 'Lesão Corporal Dolosa' AS crime_type, total_bodily_harm AS total_count FROM crime WHERE total_bodily_harm > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Celular' AS crime_type, total_theft_cellphone AS total_count FROM crime WHERE total_theft_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Celular' AS crime_type, total_armed_robbery_cellphone AS total_count FROM crime WHERE total_armed_robbery_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Veículo' AS crime_type, total_theft_auto AS total_count FROM crime WHERE total_theft_auto > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Veículo' AS crime_type, total_armed_robbery_auto AS total_count FROM crime WHERE total_armed_robbery_auto > 0
)
SELECT
    s.id AS segment_id,
    cdu.crime_type,
    SUM(cdu.total_count) AS total_occurrences
FROM
    CrimeDataUnpivoted cdu
JOIN data_time t ON cdu.time_id = t.id
JOIN segment s ON cdu.segment_id = s.id
JOIN vertice v ON s.start_vertice_id = v.id
JOIN district d ON v.district_id = d.id
WHERE
    d.name = 'IGUATEMI'
    AND t.year = 2016
GROUP BY
    s.id,
    cdu.crime_type
ORDER BY
    s.id,
    total_occurrences DESC;

WITH CrimeDataUnpivoted AS (
    SELECT segment_id, time_id, 'Feminicídio' AS crime_type, total_feminicide AS total_count FROM crime WHERE total_feminicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Homicídio Doloso' AS crime_type, total_homicide AS total_count FROM crime WHERE total_homicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Latrocínio' AS crime_type, total_felony_murder AS total_count FROM crime WHERE total_felony_murder > 0
    UNION ALL
    SELECT segment_id, time_id, 'Lesão Corporal Dolosa' AS crime_type, total_bodily_harm AS total_count FROM crime WHERE total_bodily_harm > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Celular' AS crime_type, total_theft_cellphone AS total_count FROM crime WHERE total_theft_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Celular' AS crime_type, total_armed_robbery_cellphone AS total_count FROM crime WHERE total_armed_robbery_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Veículo' AS crime_type, total_theft_auto AS total_count FROM crime WHERE total_theft_auto > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Veículo' AS crime_type, total_armed_robbery_auto AS total_count FROM crime WHERE total_armed_robbery_auto > 0
)
SELECT
    s.id AS segment_id,
    cdu.crime_type,
    SUM(cdu.total_count) AS total_occurrences_in_period
FROM
    CrimeDataUnpivoted cdu
JOIN data_time t ON cdu.time_id = t.id
JOIN segment s ON cdu.segment_id = s.id
JOIN vertice v ON s.start_vertice_id = v.id
JOIN district d ON v.district_id = d.id
WHERE
    d.name = 'IGUATEMI'
    AND t.year BETWEEN 2006 AND 2016
GROUP BY
    s.id,
    cdu.crime_type
ORDER BY
    s.id,
    total_occurrences_in_period DESC;

SELECT
    SUM(c.total_armed_robbery_cellphone) AS total_roubos_celular,
    SUM(c.total_armed_robbery_auto) AS total_roubos_carro
FROM
    crime c
JOIN DATA_time t ON c.time_id = t.id
JOIN segment s ON c.segment_id = s.id
JOIN vertice v ON s.start_vertice_id = v.id
JOIN neighborhood n ON v.neighborhood_id = n.id
WHERE
    n.name = 'SANTA EFIGENIA'
    AND t.year = 2015;

/* Not executing*/
WITH CrimeDataUnpivoted AS (
    SELECT segment_id, time_id, 'Feminicídio' AS crime_type, total_feminicide AS total_count FROM crime WHERE total_feminicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Homicídio Doloso' AS crime_type, total_homicide AS total_count FROM crime WHERE total_homicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Latrocínio' AS crime_type, total_felony_murder AS total_count FROM crime WHERE total_felony_murder > 0
    UNION ALL
    SELECT segment_id, time_id, 'Lesão Corporal Dolosa' AS crime_type, total_bodily_harm AS total_count FROM crime WHERE total_bodily_harm > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Celular' AS crime_type, total_theft_cellphone AS total_count FROM crime WHERE total_theft_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Celular' AS crime_type, total_armed_robbery_cellphone AS total_count FROM crime WHERE total_armed_robbery_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Veículo' AS crime_type, total_theft_auto AS total_count FROM crime WHERE total_theft_auto > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Veículo' AS crime_type, total_armed_robbery_auto AS total_count FROM crime WHERE total_armed_robbery_auto > 0
)
SELECT
    cdu.crime_type,
    SUM(cdu.total_count) AS total_citywide_oneway_streets
FROM
    CrimeDataUnpivoted cdu
JOIN segment s ON cdu.segment_id = s.id
JOIN data_time t ON cdu.time_id = t.id
WHERE
    s.oneway IS TRUE
    AND t.year = 2012
GROUP BY
    cdu.crime_type
ORDER BY
    total_citywide_oneway_streets DESC;


SELECT
    SUM(c.total_armed_robbery_auto) AS total_roubos_de_carro_2017,
    SUM(c.total_theft_cellphone + c.total_armed_robbery_cellphone) AS total_crimes_de_celular_2017
FROM
    crime c
JOIN data_time t ON c.time_id = t.id
WHERE
    t.year = 2017;


WITH SegmentCriminality AS (
    SELECT
        c.segment_id,
        SUM(
            c.total_feminicide + c.total_homicide + c.total_felony_murder +
            c.total_bodily_harm + c.total_theft_cellphone + c.total_armed_robbery_cellphone +
            c.total_theft_auto + c.total_armed_robbery_auto
        ) AS criminality_index
    FROM
        crime c
    JOIN data_time t ON c.time_id = t.id
    WHERE
        t.year = 2010
        AND t.month = 11 -- Novembro
    GROUP BY
        c.segment_id
),
RankedSegments AS (
    SELECT
        segment_id,
        criminality_index,
        DENSE_RANK() OVER (ORDER BY criminality_index DESC) as rnk
    FROM
        SegmentCriminality
)
SELECT
    segment_id,
    criminality_index
FROM
    RankedSegments
WHERE
    rnk = 1;

WITH WeekendSegmentCriminality AS (
    SELECT
        c.segment_id,
        SUM(
            c.total_feminicide + c.total_homicide + c.total_felony_murder +
            c.total_bodily_harm + c.total_theft_cellphone + c.total_armed_robbery_cellphone +
            c.total_theft_auto + c.total_armed_robbery_auto
        ) AS criminality_index
    FROM
        crime c
    JOIN data_time t ON c.time_id = t.id
    WHERE
        t.year = 2018
        AND t.weekday IN ('Sábado', 'Domingo')
    GROUP BY
        c.segment_id
),
RankedWeekendSegments AS (
    SELECT
        segment_id,
        criminality_index,
        DENSE_RANK() OVER (ORDER BY criminality_index DESC) as rnk
    FROM
        WeekendSegmentCriminality
)
SELECT
    segment_id,
    criminality_index
FROM
    RankedWeekendSegments
WHERE
    rnk = 1;