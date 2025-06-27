create user C##PolRouteDS identified by SYSTEM;
alter session set current_schema = C##PolRouteDS; 
GRANT ALL PRIVILEGES TO C##PolRouteDS;

CREATE TABLE district (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255) UNIQUE NOT NULL,
    geom CLOB NOT NULL
);


CREATE TABLE district_parallel (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255) UNIQUE NOT NULL,
    geom CLOB NOT NULL
);

CREATE TABLE district_frag (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255) UNIQUE NOT NULL,
    geom CLOB NOT NULL
)PARTITION BY LIST(name)(
    PARTITION district_1 VALUES('IGUATEMI'),
    PARTITION district_2 VALUES(DEFAULT)
);

CREATE TABLE neighborhood (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(4000) UNIQUE NOT NULL,
    geom CLOB NOT NULl
);

CREATE TABLE neighborhood_frag (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(4000) UNIQUE NOT NULL,
    geom CLOB NOT NULL
)PARTITION BY LIST(name)(
    PARTITION neighborhood_1 VALUES('SANTA EFIGENCIA'),
    PARTITION neighborhood_2 VALUES(DEFAULT)
);

CREATE TABLE vertice (
    id NUMBER PRIMARY KEY,
    label NUMBER NOT NULL,
    district_id NUMBER NOT NULL,
    neighborhood_id NUMBER NOT NULL,
    zone_id NUMBER NOT NULL
);

ALTER TABLE vertice ADD CONSTRAINT fk1_district FOREIGN KEY (district_id) REFERENCES district(id);
ALTER TABLE vertice ADD CONSTRAINT fk1_neighborhood  FOREIGN KEY (neighborhood_id) REFERENCES neighborhood(id);

CREATE TABLE vertice_frag (
    id NUMBER PRIMARY KEY,
    label NUMBER NOT NULL,
    district_id NUMBER NOT NULL,
    neighborhood_id NUMBER NOT NULL,
    zone_id NUMBER NOT NULL,
    CONSTRAINT fk2_district FOREIGN KEY (district_id) REFERENCES district_frag(id),
    CONSTRAINT fk2_neighborhood  FOREIGN KEY (neighborhood_id) REFERENCES neighborhood_frag(id)
)PARTITION by REFERENCE (fk2_district);



CREATE TABLE segment (
    id NUMBER(19) PRIMARY KEY,
    geom VARCHAR2(1000),
    oneway NUMBER(1),
    length NUMBER(10, 2),
    final_vertice_id NUMBER(19),
    start_vertice_id NUMBER(19)
);
ALTER TABLE segment ADD CONSTRAINT fk1_final FOREIGN KEY (final_vertice_id )
REFERENCES vertice(id);


CREATE TABLE segment_frag (
    id NUMBER(19) PRIMARY KEY,
    geom VARCHAR2(1000),
    oneway NUMBER(1),
    length NUMBER(10, 2),
    final_vertice_id NUMBER(19) NOT NULL,
    start_vertice_id NUMBER(19) NOT NULL,
    CONSTRAINT fk2_final FOREIGN KEY (final_vertice_id) 
    REFERENCES vertice_frag(id)
)PARTITION by REFERENCE (fk2_final);

CREATE TABLE date_time (
    id NUMBER PRIMARY KEY,
    period VARCHAR2(20),
    day NUMBER,
    month NUMBER,
    year NUMBER,
    weekday VARCHAR2(10)
);

CREATE TABLE data_time_frag (
    id NUMBER PRIMARY KEY,
    period VARCHAR2(20),
    day NUMBER,
    month NUMBER,
    year NUMBER,
    weekday VARCHAR2(10)
    
)PARTITION BY RANGE (year) (
    PARTITION data_1 VALUES LESS THAN (2006),
    PARTITION data_2 VALUES LESS THAN (2010),
    PARTITION data_3 VALUES LESS THAN (2012),
    PARTITION data_4 VALUES LESS THAN (2016),
    PARTITION data_5 VALUES LESS THAN (2017),
    PARTITION data_6 VALUES LESS THAN (2018),
    PARTITION data_7 VALUES LESS THAN (MAXVALUE)
);

CREATE TABLE crime (
    id NUMBER PRIMARY KEY,
    total_feminicide NUMBER,
    total_homicide NUMBER,
    total_felony_murder NUMBER,
    total_bodily_harm NUMBER,
    total_theft_cellphone NUMBER,
    total_armed_robbery_cellphone NUMBER,
    total_theft_auto NUMBER,
    total_armed_robbery_auto NUMBER,
    segment_id NUMBER,
    time_id NUMBER

);

ALTER TABLE crime ADD CONSTRAINT fk1_segment FOREIGN KEY (segment_id) REFERENCES segment(id);
ALTER TABLE crime ADD CONSTRAINT fk1_time FOREIGN KEY (time_id) REFERENCES data_time(id);

CREATE TABLE crime_frag (
    id NUMBER PRIMARY KEY,
    total_feminicide NUMBER,
    total_homicide NUMBER,
    total_felony_murder NUMBER,
    total_bodily_harm NUMBER,
    total_theft_cellphone NUMBER,
    total_armed_robbery_cellphone NUMBER,
    total_theft_auto NUMBER,
    total_armed_robbery_auto NUMBER,
    segment_id NUMBER NOT NULL,
    time_id NUMBER NOT NULL,
    /*CONSTRAINT fk2_segment FOREIGN key (segment_id) REFERENCES segment_frag(id),*/
    CONSTRAINT fk2_time FOREIGN key (time_id) REFERENCES data_time_frag(id)

)PARTITION by REFERENCE (fk2_time);

CREATE TABLE district_parallel AS SELECT /*+ PARALLEL(4) */ * FROM DISTRICT;
CREATE TABLE neighborhood_parallel AS SELECT /*+ PARALLEL(4) */ * FROM NEIGHBORHOOD;
CREATE TABLE vertice_parallel AS SELECT /*+ PARALLEL(4) */ * FROM vertice;
CREATE TABLE segment_parallel AS SELECT /*+ PARALLEL(4) */ * FROM segment;
CREATE TABLE data_time_parallel AS SELECT /*+ PARALLEL(4) */ * FROM DATA_TIME;
CREATE TABLE crime_parallel AS SELECT /*+ PARALLEL(4) */ * FROM CRIME;





