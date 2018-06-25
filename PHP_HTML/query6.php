<?php

$conn = oci_connect('user','pass', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  
  $a = $_GET['PN'];
  $b = $_GET['FN'];
  $c = $_GET['LN'];
  $f = $_GET['SD'];
  $g = $_GET['ED'];
  $d = $_GET['HP'];
  $e = $_GET['WP'];
  $h = $_GET['DP'];

  $stid = oci_parse($conn, "begin query_6(:a, :b, :c, :f, :g, :d, :e, :h); end;");
  oci_bind_by_name($stid, ":a", $a);
  oci_bind_by_name($stid, ":b", $b);
  oci_bind_by_name($stid, ":c", $c);
  oci_bind_by_name($stid, ":f", $f);
  oci_bind_by_name($stid, ":g", $g);
  oci_bind_by_name($stid, ":d", $d);
  oci_bind_by_name($stid, ":e", $e);
  oci_bind_by_name($stid, ":h", $h);


  if (oci_execute($stid) == true) {
    echo "Lease Added";
  }
  else {
    echo "Unable to Add Lease";
  }

} else {
       $e = oci_error;
       print "<br> connection failed:";
       exit;
}
OCILogoff($conn);
?>

 
 
