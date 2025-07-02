alter session set current_schema = C##PolRouteDS; 


/* 1. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016? */
WITH dtf AS (
    SELECT * 
    FROM data_time_frag 
    WHERE year = 2016
), df AS (
    SELECT *
    FROM district_frag
    WHERE name = 'IGUATEMI'
), CrimeDataUnpivoted  AS (
    SELECT segment_id, time_id, 'Feminicídio' AS crime_type, total_feminicide AS total_count FROM crime_frag WHERE total_feminicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Homicídio Doloso' AS crime_type, total_homicide AS total_count FROM crime_frag WHERE total_homicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Latrocínio' AS crime_type, total_felony_murder AS total_count FROM crime_frag WHERE total_felony_murder > 0
    UNION ALL
    SELECT segment_id, time_id, 'Lesão Corporal Dolosa' AS crime_type, total_bodily_harm AS total_count FROM crime_frag WHERE total_bodily_harm > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Celular' AS crime_type, total_theft_cellphone AS total_count FROM crime_frag WHERE total_theft_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Celular' AS crime_type, total_armed_robbery_cellphone AS total_count FROM crime_frag WHERE total_armed_robbery_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Veículo' AS crime_type, total_theft_auto AS total_count FROM crime_frag WHERE total_theft_auto > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Veículo' AS crime_type, total_armed_robbery_auto AS total_count FROM crime_frag WHERE total_armed_robbery_auto > 0
)
 SELECT
    sf.id AS segment_id,
    cdu.crime_type,
    SUM(cdu.total_count) AS total_occurrences
FROM
    CrimeDataUnpivoted cdu
JOIN dtf ON cdu.time_id = dtf.id
JOIN crime_frag cf ON dtf.id = cf.time_id
JOIN segment_frag sf ON sf.id = cf.segment_id
JOIN vertice_frag vf ON vf.id = sf.final_vertice_id /* OR vf.id = sf.start_vertive_id */
JOIN  df ON vf.district_id = df.id
GROUP BY
    sf.id,
    cdu.crime_type
ORDER BY
    sf.id,
    total_occurrences DESC;


/* 2. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI entre 2006 e 2016? */
WITH dtf AS (
    SELECT * 
    FROM data_time_frag 
    WHERE year BETWEEN 2006 AND 2016
), df AS (
    SELECT *
    FROM district
    WHERE name = 'IGUATEMI'
), CrimeDataUnpivoted AS (
    SELECT segment_id, time_id, 'Feminicídio' AS crime_type, total_feminicide AS total_count FROM crime_frag WHERE total_feminicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Homicídio Doloso' AS crime_type, total_homicide AS total_count FROM crime_frag WHERE total_homicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Latrocínio' AS crime_type, total_felony_murder AS total_count FROM crime_frag WHERE total_felony_murder > 0
    UNION ALL
    SELECT segment_id, time_id, 'Lesão Corporal Dolosa' AS crime_type, total_bodily_harm AS total_count FROM crime_frag WHERE total_bodily_harm > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Celular' AS crime_type, total_theft_cellphone AS total_count FROM crime_frag WHERE total_theft_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Celular' AS crime_type, total_armed_robbery_cellphone AS total_count FROM crime_frag WHERE total_armed_robbery_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Veículo' AS crime_type, total_theft_auto AS total_count FROM crime_frag WHERE total_theft_auto > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Veículo' AS crime_type, total_armed_robbery_auto AS total_count FROM crime_frag WHERE total_armed_robbery_auto > 0
)
SELECT
    sf.id AS segment_id,
    cdu.crime_type,
    SUM(cdu.total_count) AS total_occurrences_in_period
FROM
    CrimeDataUnpivoted cdu
JOIN dtf ON cdu.time_id = dtf.id
JOIN crime_frag cf ON dtf.id = cf.time_id
JOIN segment_frag sf ON sf.id = cf.segment_id
JOIN vertice_frag vf ON vf.id = sf.final_vertice_id /* OR vf.id = sf.start_vertive_id */
JOIN df ON vf.district_id = df.id
GROUP BY
    sf.id,
    cdu.crime_type
ORDER BY
    sf.id,
    total_occurrences_in_period DESC;


/* 3. Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015? */
WITH dtf AS (
    SELECT * 
    FROM data_time_frag 
    WHERE year = 2015
), ngf AS (
    SELECT *
    FROM neighborhood_frag
    WHERE name = 'Santa Efigenia'
    /*WHERE name LIKE 'Santa Efi%'*/
)
SELECT
    SUM(cf.total_armed_robbery_cellphone) AS total_roubos_celular,
    SUM(cf.total_armed_robbery_auto) AS total_roubos_carro
FROM
    crime_frag cf
JOIN dtf ON dtf.id = cf.time_id
JOIN segment_frag sf ON sf.id = cf.segment_id 
JOIN vertice_frag vf ON vf.id = sf.final_vertice_id /* OR vf.id = sf.start_vertive_id */
JOIN ngf ON ngf.id = vf.neighborhood_id;


/* 4. Qual o total de crimes por tipo em vias de mão única da cidade durante o ano de 2012? */
WITH dtf AS (
    SELECT * 
    FROM data_time_frag 
    WHERE year = 2012
), sf AS (
    SELECT *
    FROM segment_frag
      WHERE oneway = 1 
), CrimeDataUnpivoted AS (
    SELECT segment_id, time_id, 'Feminicídio' AS crime_type, total_feminicide AS total_count FROM crime_frag WHERE total_feminicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Homicídio Doloso' AS crime_type, total_homicide AS total_count FROM crime_frag WHERE total_homicide > 0
    UNION ALL
    SELECT segment_id, time_id, 'Latrocínio' AS crime_type, total_felony_murder AS total_count FROM crime_frag WHERE total_felony_murder > 0
    UNION ALL
    SELECT segment_id, time_id, 'Lesão Corporal Dolosa' AS crime_type, total_bodily_harm AS total_count FROM crime_frag WHERE total_bodily_harm > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Celular' AS crime_type, total_theft_cellphone AS total_count FROM crime_frag WHERE total_theft_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Celular' AS crime_type, total_armed_robbery_cellphone AS total_count FROM crime_frag WHERE total_armed_robbery_cellphone > 0
    UNION ALL
    SELECT segment_id, time_id, 'Furto de Veículo' AS crime_type, total_theft_auto AS total_count FROM crime_frag WHERE total_theft_auto > 0
    UNION ALL
    SELECT segment_id, time_id, 'Roubo de Veículo' AS crime_type, total_armed_robbery_auto AS total_count FROM crime_frag WHERE total_armed_robbery_auto > 0
)
SELECT
    cdu.crime_type,
    SUM(cdu.total_count) AS total_citywide_oneway_streets
FROM
    CrimeDataUnpivoted cdu
JOIN sf ON sf.id = cdu.segment_id
JOIN dtf ON dtf.id = cdu.time_id
GROUP BY
    cdu.crime_type
ORDER BY
    total_citywide_oneway_streets DESC;


/* 5. Qual o total de roubos de carro e celular em todos os segmentos durante o ano de 2017? */
SELECT
    SUM(cf.total_armed_robbery_auto) AS total_roubos_de_carro_2017,
    SUM(cf.total_theft_cellphone + cf.total_armed_robbery_cellphone) AS total_crimes_de_celular_2017
FROM
    crime_frag cf
JOIN data_time_frag dtf ON cf.time_id = dtf.id
WHERE
    dtf.year = 2017;


/* 6. Quais os IDs de segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes), durante o mês de Novembro de 2010?*/
WITH SegmentCriminality AS (
    SELECT
        cf.segment_id,
        SUM(
            cf.total_feminicide + cf.total_homicide + cf.total_felony_murder +
            cf.total_bodily_harm + cf.total_theft_cellphone + cf.total_armed_robbery_cellphone +
            cf.total_theft_auto + cf.total_armed_robbery_auto
        ) AS criminality_index
    FROM
        crime_frag cf
    JOIN data_time_frag dtf ON cf.time_id = dtf.id
    WHERE
        dtf.year = 2010
        AND dtf.month = 11 /* Novembro */
    GROUP BY
        cf.segment_id
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
        cf.segment_id,
        SUM(
            cf.total_feminicide + cf.total_homicide + cf.total_felony_murder +
            cf.total_bodily_harm + cf.total_theft_cellphone + cf.total_armed_robbery_cellphone +
            cf.total_theft_auto + cf.total_armed_robbery_auto
        ) AS criminality_index
    FROM
        crime_frag cf
    JOIN data_time_frag dtf ON cf.time_id = dtf.id
    WHERE
        dtf.year = 2018
        AND dtf.weekday IN ('saturday', 'sunday')
    GROUP BY
        cf.segment_id
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