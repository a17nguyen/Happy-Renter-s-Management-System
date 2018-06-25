<?php

$conn = oci_connect('user','pass', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  
  $curs;
  $stid = oci_parse($conn, "begin :r := query_5; end;");
  oci_bind_by_name($stid, ":r", $curs, 1000);

  oci_execute($stid);
  echo $curs;


} else {
       $e = oci_error;
       print "<br> connection failed:";
       exit;
}
OCILogoff($conn);
?>

 
 
