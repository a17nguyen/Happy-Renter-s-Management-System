Drop Table Lease_Agreement;
Drop Table Rental_Property;
Drop Table Employees;
Drop Table Supervisor;
Drop Table Branch;
Drop Table Property_Owner;
Drop Table Manager;

Create Table Manager(
    managerId int PRIMARY KEY,
    firstName varchar(20),
    lastName varchar(20),
	phone varchar(10)
);

Create Table Branch(
    branchNo int PRIMARY KEY,
    managerId int unique,
    branchPhone varchar(10),
    streetNum int,
   	branchStreet varchar(20),
    branchCity varchar (20),
    branchZip int,
    FOREIGN KEY(managerId) REFERENCES Manager(managerId)
);

Create Table Supervisor(
    supervisorId int PRIMARY KEY,
    managerId int,
    firstName varchar(20),
    lastName varchar(20),
    supervisorPhone varchar(10),
    FOREIGN KEY(managerId) REFERENCES Manager(managerId)
);

Create Table Employees(
    empId int PRIMARY KEY,
    branchId int,
    firstName varchar(20),
    lastName varchar(20),
    empPhone varchar(10),
	empJob varchar(10) check (empJob in ('supervisor', 'manager')),
    FOREIGN KEY(branchId) REFERENCES Branch(branchNo)
);

Create Table Property_Owner(
	ownerID int PRIMARY KEY,
    firstName varchar(20),
    lastName varchar(20),
    streetNo int,
    ownerStreet varchar(20),
    ownerCity varchar(20),
    ownerZip int,
    ownerPhone varchar(10)
);

Create Table Rental_Property(
    propertyNo int Primary Key,
    ownerId int,
	supervisorId int,
    streetNo int,
    streetName varchar(20),
    city varchar(20),
    propertyZip int,
    numRooms int,
    monthlyRent number(10, 2),
    status varchar (20) check (status in ('available', 'leased')),
    dateAvail date,
	Foreign Key(supervisorId) References Supervisor(supervisorId),
    Foreign Key(ownerId) References Property_Owner(ownerId)
);


Create Table Lease_Agreement(
    leaseId int PRIMARY KEY,
    propertyNo int,
	firstName varchar(20),
	lastname varchar(20),
    startDate date,
    endDate date,
	homePhone varchar(10),
  	workPhone varchar(10),
    rentAmount number(10,2),
	deposit number(10,2),
    Foreign Key(propertyNo) References Rental_Property(propertyNo),
	Check (Months_Between(endDate, startDate) >= 6 AND Months_Between(endDate, startDate) <= 12)
);



