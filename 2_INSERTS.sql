alter session set current_schema = C##PolRouteDS; 

INSERT INTO district_frag SELECT * FROM district;
INSERT INTO neighborhood_frag SELECT * FROM neighborhood;
INSERT INTO vertice_frag SELECT * from vertice;
INSERT INTO segment_frag SELECT * from segments;
INSERT INTO data_time_frag SELECT * from data_time;
INSERT INTO crime_frag SELECT * from crime;

