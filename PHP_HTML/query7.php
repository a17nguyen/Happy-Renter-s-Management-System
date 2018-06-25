<?php

$conn = oci_connect('user','pass', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  $p = $_GET['firstname'];
  $l = $_GET['lastname'];
 
  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_7(:p,:l); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":p", $p);
  oci_bind_by_name($stid, ":l", $l);

  oci_execute($stid);
  oci_execute($curs);  

  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
	  echo "<br>";
  	echo "Name: ", $row['FULLNAME'], "</br>";
  	echo "Home Phone: ", $row['HOMEPHONE'], "</br>";
  	echo "Work Phone: ", $row['WORKPHONE'], "</br>";
  	echo "Start Date (DD-M-YY): ", $row['STARTDATE'], "</br>";
  	echo "End Date (DD-M-YY): ", $row['ENDDATE'], "</br>";
  	echo "Deposit: ", $row['DEPOSIT'], "</br>";
  	echo "Rent Amount ", $row['RENTAMOUNT'], "</br>";
  }

} else {
       $e = oci_error;
       print "<br> connection failed:";
       exit;
}
OCILogoff($conn);
?>

