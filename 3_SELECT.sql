alter session set current_schema = C##PolRouteDS; 


/* 1. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016? */
WITH dt AS (
    SELECT * 
    FROM data_time 
    WHERE year = 2016
), d AS (
    SELECT *
    FROM district
    WHERE name = 'IGUATEMI'
), CrimeDataUnpivoted  AS (
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
JOIN dt ON cdu.time_id = dt.id
JOIN crime c ON dt.id = c.time_id
JOIN segments s ON s.id = c.segment_id
JOIN vertice v ON v.id = s.final_vertice_id /* OR v.id = s.start_vertive_id */
JOIN  d ON v.district_id = d.id
GROUP BY
    s.id,
    cdu.crime_type
ORDER BY
    s.id,
    total_occurrences DESC;


/* 2. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI entre 2006 e 2016? */
WITH dt AS (
    SELECT * 
    FROM data_time 
    WHERE year BETWEEN 2006 AND 2016
), d AS (
    SELECT *
    FROM district
    WHERE name = 'IGUATEMI'
), CrimeDataUnpivoted AS (
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
JOIN dt ON cdu.time_id = dt.id
JOIN crime c ON dt.id = c.time_id
JOIN segments s ON s.id = c.segment_id
JOIN vertice v ON v.id = s.final_vertice_id /* OR v.id = s.start_vertive_id */
JOIN d ON v.district_id = d.id
GROUP BY
    s.id,
    cdu.crime_type
ORDER BY
    s.id,
    total_occurrences_in_period DESC;


/* 3. Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015? */
WITH dt AS (
    SELECT * 
    FROM data_time 
    WHERE year = 2015
), ng AS (
    SELECT *
    FROM neighborhood
    WHERE name = 'SANTA EFIGENIA'
    /*WHERE name LIKE 'Santa Efi%'*/
)
SELECT
    SUM(c.total_armed_robbery_cellphone) AS total_roubos_celular,
    SUM(c.total_armed_robbery_auto) AS total_roubos_carro
FROM
    crime c
JOIN dt ON dt.id = c.time_id
JOIN segments s ON s.id = c.segment_id 
JOIN vertice v ON v.id = s.final_vertice_id /* OR v.id = s.start_vertive_id */
JOIN ng ON ng.id = v.neighborhood_id;


/* 4. Qual o total de crimes por tipo em vias de mão única da cidade durante o ano de 2012? */
WITH dt AS (
    SELECT * 
    FROM data_time 
    WHERE year = 2012
), s AS (
    SELECT *
    FROM segments
      WHERE oneway = 1 

), CrimeDataUnpivoted AS (
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
JOIN s ON s.id = cdu.segment_id
JOIN dt ON dt.id = cdu.time_id
GROUP BY
    cdu.crime_type
ORDER BY
    total_citywide_oneway_streets DESC;


/* 5. Qual o total de roubos de carro e celular em todos os segmentos durante o ano de 2017? */
SELECT
    SUM(c.total_armed_robbery_auto) AS total_roubos_de_carro_2017,
    SUM(c.total_theft_cellphone + c.total_armed_robbery_cellphone) AS total_crimes_de_celular_2017
FROM
    crime c
JOIN data_time dt ON c.time_id = dt.id
WHERE
    dt.year = 2017;


/* 6. Quais os IDs de segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes), durante o mês de Novembro de 2010?*/
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
    JOIN data_time dt ON c.time_id = dt.id
    WHERE
        dt.year = 2010
        AND dt.month = 11 /* Novembro */
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


/* 7. Quais os IDs dos segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes) durante os finais de semana do ano de 2018? */
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
    JOIN data_time dt ON c.time_id = dt.id
    WHERE
        dt.year = 2018
        AND dt.weekday IN ('saturday', 'sunday')
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