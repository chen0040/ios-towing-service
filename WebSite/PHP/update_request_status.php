<?php

$userId=$_POST['userId'];
$id=$_POST['id'];
$status=$_POST['status'];

$m_host_name="localhost";
$m_username="root";
$m_password="chen0469";
$m_database="mysql";
mysql_connect($m_host_name, $m_username, $m_password) or die(mysql_error());
mysql_select_db($m_database) or die(mysql_error());

$query="UPDATE aas_callservices SET status=$status WHERE userId='$userId' AND rec_id='$id';";

mysql_query($query) or die(mysql_error());

//echo $query;

mysql_close();

echo 'Call Request Status Updated! for userId='.$userId.' and rec_id='.$id ;

?>