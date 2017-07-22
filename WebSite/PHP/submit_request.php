<?php

$userId=$_POST['userId'];
$idType=$_POST['idType'];
$name=$_POST['name'];
$contactNumber=$_POST['contactNumber'];
$carMake=$_POST['carMake'];
$carModel=$_POST['carModel'];
$carColor=$_POST['carColor'];
$carNumber=$_POST['carNumber'];
$lat=$_POST['lat'];
$lng=$_POST['lng'];
$address=$_POST['address'];
$note=$_POST['note'];
$id=$_POST['id'];
$status=$_POST['status'];

$m_host_name="localhost";
$m_username="root";
$m_password="chen0469";
$m_database="mysql";
mysql_connect($m_host_name, $m_username, $m_password) or die(mysql_error());
mysql_select_db($m_database) or die(mysql_error());

$query="INSERT INTO aas_callservices (userId, idType, name, contactNumber, carMake, carModel, carColor, carNumber, lat, lng, address, note, comment, status, submit_time, rec_id) VALUES ('$userId', $idType, '$name', '$contactNumber', '$carMake', '$carModel', '$carColor', '$carNumber', $lat, $lng, '$address', '$note', '', $status, 'NOW()', '$id');";

mysql_query($query) or die(mysql_error());

//echo $query;

mysql_close();

echo 'Call Request Received: userId is '.$userId.' and idType is '.$idType.' and name is '.$name.' and contactNumber is '.$contactNumber.' and carMake is '.$carMake.' and carModel is '.$carModel.' and carColor is '.$carColor.' and carNumber is '.$carNumber.' and lat is '.$lat.' and lng is '.$lng.' and address is '.$address.' and note is '.$note;

?>