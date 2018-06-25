insert into Manager values(1, 'Andrew', 'Nguyen', '4081211311');
insert into Manager values(2, 'Kelly', 'Ouye', '8456209988');
insert into Manager values(3, 'Jonathan', 'Chao', '1802249077');
insert into Manager values(4, 'Vanessa', 'Au', '6053219876');
insert into Manager values(5, 'Megan', 'Huang', '4084587043');

insert into Branch values(1, 1, '4088386939', 1234, 'Piedmont Rd.', 'San Jose', 95132);
insert into Branch values(2, 3, '4088028089', 780, 'Hostettor Rd.', 'San Jose', 95132);
insert into Branch values(3, 5, '4089338813', 730, 'Harrison', 'Santa Clara', 95053);
insert into Branch values(4, 2, '6692274563', 124, 'Fremont', 'Santa Clara', 95053);
insert into Branch values(5, 4, '5106892804', 550, 'Market', 'San Francisco', 95122);

insert into Supervisor values(6, 1, 'Brandon', 'Thai', '6693356822');
insert into Supervisor values(7, 3, 'Dante', 'Noffal', '6029103925');
insert into Supervisor values(8, 5, 'Iris', 'Feng', '6691267834');
insert into Supervisor values(9, 2, 'Rainey', 'Chak', '4085880022');
insert into Supervisor values(10, 4, 'Huy', 'Dinh', '4084104100');
insert into Supervisor values(11, 4, 'Erik', 'Nguyen', '4084212312');
insert into Supervisor values(12, 3, 'Erik', 'Nguyen', '4084212312');

insert into Employees values(1, 1, 'Andrew', 'Nguyen', '4081211311', 'manager');
insert into Employees values(2, 2, 'Kelly', 'Ouye', '8456209988', 'manager');
insert into Employees values(3, 3, 'Jonathan', 'Chao', '1802249077', 'manager');
insert into Employees values(4, 4, 'Vanessa', 'Au', '6053219876', 'manager');
insert into Employees values(5, 5, 'Megan', 'Huang', '4084587043', 'manager');
insert into Employees values(6, 1, 'Brandon', 'Thai', '6693356822', 'supervisor');
insert into Employees values(7, 3, 'Dante', 'Noffal', '6029103925', 'supervisor');
insert into Employees values(8, 5, 'Iris', 'Feng', '6691267834', 'supervisor');
insert into Employees values(9, 2, 'Rainey', 'Chak', '4085880022', 'supervisor');
insert into Employees values(10, 4, 'Huy', 'Dinh', '4084104100', 'supervisor');

insert into property_Owner values (1, 'Annie', 'Xu', 900, 'Berryessa Rd.', 'San Jose', 95132, '4082924465');
insert into property_Owner values (2, 'Kerry', 'Xu', 901, 'Berryessa Rd.', 'San Jose', 95132, '4085922456');
insert into property_Owner values (3, 'Joshua', 'Chao', 430, 'Bento', 'Fremont', 95221, '5105102222');
insert into property_Owner values (4, 'Kevin', 'Shi', 1203, 'Alameda', 'Santa Clara', 95053, '1493385432');
insert into property_Owner values (5, 'William', 'Hao', 2902, 'Hive', 'Cupertino', 95033, '4082444465');

insert into rental_Property values (1, 3, 6, 405, 'El Camino', 'Santa Clara', 95053, 4, 100, 'available', date '2017-11-11');
insert into rental_Property values (2, 5, 8, 555, 'Jump St', 'Wallstreet', 95430, 1, 1000, 'available', date '2018-10-11');
insert into rental_Property values (3, 2, 7, 1435, 'Downey', 'San Jose', 95014, 4, 420, 'leased', date '2019-09-11');
insert into rental_Property values (4, 1, 10, 2291, 'Washington Ave', 'SanTa Clara', 95243, 2, 250, 'available', date '2016-05-11');
insert into rental_Property values (5, 1, 9, 2544, 'Washington Ave', 'Santa Clara', 95243, 2, 250, 'available', date '2017-05-11');
insert into rental_Property values (6, 1, 11, 333, 'Washington Ave', 'Santa Clara', 95243, 2, 300, 'available', date '2017-05-11');
insert into rental_Property values (7, 1, 7, 331, 'Washington Ave', 'Santa Clara', 95243, 2, 300, 'available', date '2017-05-11');

insert into Lease_Agreement values(100, 1, 'Katrina', 'Li', date '2017-11-11', date '2018-10-11', '4449991111', '1029375039', 100, 50);
insert into Lease_Agreement values(101, 2, 'William', 'Villamayor', date '2018-10-11', date '2019-09-11', '1827539385', '1111222233', 1000, 500);
insert into Lease_Agreement values(102, 3, 'Arshi', 'Jujara', date '2019-09-11', date '2020-07-11', '0285736491', '1204596739', 420, 100);
insert into Lease_Agreement values(103, 4, 'Horatio', 'Xiao', date '2016-05-11', date '2017-03-11', '1029572049', '4938233333', 250, 100);
insert into Lease_Agreement values(104, 5, 'Bryan', 'Hsu', date '2017-05-11', date '2018-01-11', '1029384756', '1567923455', 250, 50);
insert into Lease_Agreement values(105, 6, 'Bryan', 'Hsu', date '2018-05-11', date '2019-01-11', '1029384756', '1567923455', 250, 50);
insert into Lease_Agreement values(106, 6, 'Erik', 'Nguyen', date '2017-09-11', date '2018-07-11', '1029384756', '1567923455', 250, 50);

Select * from manager;
Select * from branch;
Select * from Supervisor;
Select * from employees;
Select * from Property_Owner;
Select * from Rental_Property;
Select * from Lease_agreement;

