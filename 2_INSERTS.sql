drop table crime;
drop table data;
drop table segment;
drop table vertice;
drop table neighborhood;
drop table district;

select * from neighborhood;

sqlldr SYSTEM/root@//127.0.0.1:1521/XE control=district.ctl log=district.log bad=district.bad direct=true skip=1