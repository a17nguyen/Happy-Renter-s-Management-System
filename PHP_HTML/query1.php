<?php

$conn = oci_connect('user','pass', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  $p = $_GET['branchNo'];
 
  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_1(:p); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":p", $p);

  oci_execute($stid);
  oci_execute($curs);

  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
  	echo "<br>";
  	echo "Manager Name: ", $row['FULLNAME'], "</br>";
  	echo "Address: ", $row['ADDRESS'], "</br>";
  }

} else {
       $e = oci_error;
       print "<br> connection failed:";
       exit;
}
OCILogoff($conn);
?>

 

