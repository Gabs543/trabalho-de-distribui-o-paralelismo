alter session set current_schema = C##PolRouteDS; 


drop table crime;
drop table data_time;
drop table segment;
drop table vertice;
drop table neighborhood;
drop table district;

select * from  C##PolRouteDS.crime;

sqlldr SYSTEM/root@//127.0.0.1:1521/XE control=data_time.ctl log=data_time.log bad=data_time.bad direct=true skip=1