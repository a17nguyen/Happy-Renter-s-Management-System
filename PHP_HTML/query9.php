<?php

$conn = oci_connect('user','pass', '//dbserver.engr.scu.edu/db11g');
if($conn) {

  $city = $_GET['city'];

  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_9(:city); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":city", $city);

  oci_execute($stid);
  oci_execute($curs); 

  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
  	echo "<br>";
  	echo "Average Rent: ", "$", round($row['AVG(MONTHLYRENT)'], 2), "</br>";
  	echo "City: ", $row['CITY'], "</br>";
  }

} else {
       $e = oci_error;
       print "<br> connection failed:";
       print htmlentities($e['message']);
       exit;
}
OCILogoff($conn);
?>

