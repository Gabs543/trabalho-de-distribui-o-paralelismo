CREATE TABLE district {
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    geom GEOMETRY NOT NULL
}

CREATE TABLE neighborhood (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    geom GEOMETRY NOT NULL
);

CREATE TABLE vertice (
    id INTEGER PRIMARY KEY,
    label INTEGER NOT NULL,
    district_id INTEGER NOT NULL,
    neighborhood_id INTEGER NOT NULL,
    zone_id INTEGER NOT NULL
);

CREATE TABLE segment (
    id BIGINT PRIMARY KEY,
    geom GEOMETRY,
    oneway BOOLEAN,
    length NUMERIC(10, 2),
    final_vertice_id BIGINT,
    start_vertice_id BIGINT
);

CREATE TABLE data (
    id SERIAL PRIMARY KEY,
    period VARCHAR(20),
    day INTEGER,
    month INTEGER,
    year INTEGER,
    weekday VARCHAR(10)
)

CREATE TABLE crime (
    id INTEGER PRIMARY KEY,
    total_feminicide INTEGER,
    total_homicide INTEGER,
    total_felony_murder INTEGER,
    total_bodily_harm INTEGER,
    total_theft_cellphone INTEGER,
    total_armed_robbery_cellphone INTEGER,
    total_theft_auto INTEGER,
    total_armed_robbery_auto INTEGER,
    segment_id INTEGER,
    time_id INTEGER
);