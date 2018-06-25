<?php

$conn = oci_connect('user', 'pass', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  $p = $_GET['firstname'];
  $q = $_GET['lastname'];
  $r = $_GET['branch'];
 
  $curs = "";
  $stid = oci_parse($conn, "begin :n := query_3(:p, :q, :r); end;");
  oci_bind_by_name($stid, ":n", $curs, 300);
  oci_bind_by_name($stid, ":p", $p);
  oci_bind_by_name($stid, ":q", $q);
  oci_bind_by_name($stid, ":r", $r);

  oci_execute($stid);
  echo $curs;

} else {
       $e = oci_error;
       print "<br> connection failed:";
       exit;
}
OCILogoff($conn);
?>
