/* Change status to leased */
CREATE OR REPLACE trigger availTo_Leased
for INSERT ON lease_Agreement
compound trigger
    
  l_pNo lease_Agreement.propertyNo%type;

  before each row is
  BEGIN
    l_pno := :new.propertyNo;
  END before each row;

  after statement is 
  BEGIN
    UPDATE Rental_Property SET status = 'leased' 
    WHERE propertyNo = l_pNo;
  END after statement;
END;
/
show errors;

/* Increase Rental Price */
CREATE OR REPLACE trigger updateRent 
for INSERT ON Lease_Agreement
  compound trigger
    
    r_pNo rental_Property.propertyNo%type;
    l_rnt lease_Agreement.rentAmount%type;

  before each row is
  BEGIN
    r_pNo:= :new.propertyNo;
    l_rnt:= :new.rentAmount;
  END before each row;

  after statement is
  BEGIN
     UPDATE Rental_Property SET monthlyRent = 1.1 * l_rnt 
     WHERE propertyNo = r_pNo;
  END after statement;
END;
/
show errors;

------------------------------------------------------------------------------------
/* 1. Generate a list of rental properties available for a specific branch along 
	with the manager’s name. */

CREATE OR REPLACE function query_1(b_no IN branch.branchNo%type)
return sys_refcursor is returnCursor sys_refcursor;

BEGIN
    open returnCursor for 
    SELECT r.streetNo || ' ' || r.streetName || ' ' || r.City || ' ' || r.propertyZip AS ADDRESS, 
    m.firstName ||  ' ' || m.lastName AS FULLNAME 
    FROM Rental_Property r INNER JOIN Supervisor s 
    ON s.supervisorId = r.supervisorID INNER JOIN Manager m 
    ON m.managerId = s.managerID 
    WHERE m.managerId = (SELECT managerID from Branch where branchNo = b_no);

    return returnCursor;
END;
/
Show Errors

select query_1(2) from dual;
------------------------------------------------------------------------------
/* 2. Generate a list of supervisors and the properties they supervise */

CREATE OR REPLACE function query_2
return sys_refcursor is returnCursor sys_refcursor;

BEGIN
  open returnCursor for 
  SELECT firstName ||  ' ' || lastName AS FULLNAME, 
  streetNo || ' ' || streetName || ' ' || city || ' ' || propertyZip AS ADDRESS 
  FROM Supervisor INNER JOIN Rental_Property 
  ON Supervisor.supervisorId = Rental_Property.SupervisorId;

  return returnCursor;
end;
/
show errors

select query_2 from dual;
-----------------------------------------------------------------------------
/* 3. Generate a list of rental properties by a specific owner, listed in a branch */

CREATE OR REPLACE function query_3(o_first in Property_Owner.firstName%type, o_last in Property_Owner.lastName%type, b_no in Branch.branchNo%type)
Return Varchar
AS
	list_properties varchar(300) := ' ';
	m_id Manager.managerId%type;
	o_Id int;

BEGIN
	SELECT managerId
	INTO m_id
	From Branch
	WHERE branchNo = b_no;
	
	SELECT ownerId
	INTO o_Id
	From Property_Owner
	Where firstName = o_first AND lastName = o_last;	

	SELECT LISTAGG(TO_CHAR(propertyNo), ', ')
	WITHIN Group (Order By propertyNo)
  	INTO list_properties	
	FROM Rental_Property
	WHERE Rental_Property.ownerId = o_Id AND Rental_Property.supervisorId 
	IN (SELECT supervisorId FROM Supervisor WHERE managerId = m_id);

	return o_first || ' ' || o_last || ' owns the following Property Numbers: ' || chr(10) || list_properties;
END;
/
Show Errors;

select query_3('Annie', 'Xu', 5) from dual; 
-------------------------------------------------------------------------------
/* 4. Show a listing of properties available, where the properties should satisfy the criteria*/

CREATE OR REPLACE function query_4(r_city IN Rental_Property.city%type, r_rooms in rental_Property.numRooms%type, r_lo in rental_Property.monthlyRent%type, r_hi in rental_Property.monthlyRent%type)
return sys_refcursor is returnCursor sys_refcursor;
BEGIN
	open returnCursor for select streetNo || ' ' || streetName || ' ' || city || ' ' || propertyZip AS ADDRESS, 
	numRooms, monthlyRent from rental_Property 
	where city = r_city and numRooms = r_rooms and monthlyRent 
	between r_lo and r_hi and status = 'available';

	return returnCursor;
END;
/
show errors

select query_4('Santa Clara', 2, 0, 500) from dual;
--------------------------------------------------------------------------------
/* 5. Show the number of properties available for rent */
CREATE OR REPLACE function query_5
return Varchar
As
	Cursor branch_cursor 
	IS SELECT branchNo
	FROM Branch;

	m_id Manager.managerId%type;
	b_no Branch.branchNo%type;
	b_id int;
	property_list varchar(100);
	result varchar(400);

BEGIN
	FOR branch_id_in_cursor
	In branch_cursor
	LOOP
		SELECT managerId, branchNo
		Into m_Id, b_No
		FROM Branch
		WHERE branchNo = branch_id_in_cursor.branchNo;

		SELECT TO_CHAR(COUNT(*))
		INTO property_list
		FROM Rental_Property
		WHERE supervisorId IN (
			SELECT supervisorId 
			FROM Supervisor 
			WHERE managerId = m_Id) 
		AND status = 'available';

		result := result || 'BranchNo' || b_No || ': ' || property_list || ' | ' || chr(10);
	END LOOP;

	return result;
END;
/
Show Errors;

select query_5 from dual;
---------------------------------------------------------------------------
/* 6. Create a lease agreement. */

create sequence nextLeaseId
start with 1
increment by 1
minvalue 1
maxvalue 100;

CREATE OR REPLACE procedure query_6(
l_pNo in lease_Agreement.propertyNo%type,
l_fn in lease_Agreement.firstName%type,
l_ln in lease_Agreement.lastName%type,
l_sd in varchar2,
l_ed in varchar2,
l_hp in lease_Agreement.homePhone%type,
l_wp in lease_Agreement.workPhone%type,
l_dp in lease_Agreement.deposit%type)

AS
 isAdded int;
 r_pNo rental_Property.propertyNo%type;
 tempCursor sys_refcursor;

  l_start date;
  l_end date;
  l_rnt lease_Agreement.rentAmount%type;

BEGIN

  l_start := to_date(l_sd, 'YYYY.MM.DD.');
  l_end := to_date(l_ed, 'YYYY.MM.DD.');

  SELECT monthlyRent 
  INTO l_rnt 
  FROM Rental_Property 
  WHERE propertyNo = l_pNo;

  INSERT INTO Lease_Agreement VALUES (
    nextLeaseId.nextVal,
    l_pNo,
    l_fn,
    l_ln,
   	l_start,
    l_end,
    l_hp,
    l_wp,
    l_rnt,
    l_dp
  );

END;
/
Show Errors

execute query_6(4, 'Lydia', 'V', date '2018-01-03', date '2018-09-03', '5109991111', '4321231234', 210);
select * from lease_agreement;
----------------------------------------------------------------------------
/* 7. Show a lease agreement for a renter */

CREATE OR REPLACE function query_7(l_fn in Lease_Agreement.firstName%type, l_ln in Lease_Agreement.lastName%type)
return sys_refcursor is returnCursor sys_refcursor;

BEGIN
	open returnCursor for 
	SELECT firstName ||  ' ' || lastName AS FULLNAME, 
	leaseId, homePhone, workPhone, startDate, endDate, deposit, rentAmount 
	FROM Lease_Agreement WHERE firstName = l_fn and lastName = l_ln;

	return returnCursor;
END;
/
show errors

select query_7('L', 'V') from dual;
-----------------------------------------------------------------------------------
/* 8. Show the renter who rented more than one property */

CREATE OR REPLACE function query_8
return sys_refcursor is returnCursor sys_refcursor;

BEGIN

  open returnCursor for 
  SELECT firstName || ' ' || lastName as FULLNAME 
  FROM Lease_Agreement 
  GROUP BY firstName, lastName 
  having count(*) > 1;

  return returnCursor;
END;
/
show errors

select query_8 from dual;
---------------------------------------------------------------------------------------
/* 9. Show the average rent for properties in a town */

CREATE OR REPLACE function query_9(r_city in rental_Property.city%type)
return sys_refcursor is returnCursor sys_refcursor;

BEGIN
  open returnCursor for 
  SELECT avg(monthlyRent), city 
  FROM Rental_Property 
  GROUP BY city 
  HAVING city = r_city;

  return returnCursor;
END;
/
show errors

select query_9('Santa Clara') from dual;
-----------------------------------------------------------------------------------------
/* 10. Show the names and addresses of properties whose leases will expire in next two months */

CREATE OR REPLACE function query_10
return sys_refcursor is returnCursor sys_refcursor;

BEGIN
  	open returnCursor FOR 
	SELECT firstName || ' ' || lastName 
	AS fullName, streetNo || ' ' || streetName || ' ' || city || ' ' || propertyzip as address, 
	endDate FROM Lease_Agreement INNER JOIN Rental_Property 
	ON Lease_Agreement.propertyNo = Rental_Property.propertyNo
    WHERE months_between(endDate,sysdate) <= 2 AND status = 'leased';
  	
	return returnCursor;
END;
/
show errors

select query_10 from dual;

