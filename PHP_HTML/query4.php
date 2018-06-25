 
<?php

$conn = oci_connect('user','pass', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  
  $city = $_GET['city'];
  $roomAmt = $_GET['roomAmt'];
  $Lo = $_GET['Lo'];
  $Hi = $_GET['Hi'];

  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_4(:city, :roomAmt, :Lo, :Hi); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":city", $city);
  oci_bind_by_name($stid, ":roomAmt", $roomAmt);
  oci_bind_by_name($stid, ":Lo", $Lo);
  oci_bind_by_name($stid, ":Hi", $Hi);

  oci_execute($stid);
  oci_execute($curs);  

  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
  	echo "<br>";
  	echo "Address: ", $row['ADDRESS'], "</br>";
  	echo "Number of Rooms: ", $row['NUMROOMS'], "</br>";
  	echo "Monthly Rent: ", $row['MONTHLYRENT'], "</br>";
  }

} else {
       $e = oci_error;
       print "<br> connection failed:";
       print htmlentities($e['message']);
       exit;
}
OCILogoff($conn);
?>
