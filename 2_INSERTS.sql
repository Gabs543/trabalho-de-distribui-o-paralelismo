alter session set current_schema = C##PolRouteDS; 

INSERT INTO district_frag SELECT * FROM district;
INSERT INTO neighborhood_frag SELECT * FROM neighborhood;
INSERT INTO vertice_frag SELECT * from vertice;
INSERT INTO segment_frag SELECT * from segment;
INSERT INTO data_time_frag SELECT * from data_time;
INSERT INTO crime_frag SELECT * from crime;

select * from DATA_TIME_FRAG;

SELECT * from district_frag order by ID;
select * from  C##PolRouteDS.district WHERE name != 'IGUATEMI';
SELECT * from C##POLROUTEDS.district_frag WHERE name != 'IGUATEMI';
