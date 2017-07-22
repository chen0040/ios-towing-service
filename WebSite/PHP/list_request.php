<?php

$m_host_name="localhost";
$m_username="root";
$m_password="chen0469";
$m_database="mysql";
mysql_connect($m_host_name, $m_username, $m_password) or die(mysql_error());
mysql_select_db($m_database) or die(mysql_error());

$query="SELECT userId, idType, name, contactNumber, carMake, carModel, carColor, carNumber, lat, lng, address, note, comment, status, submit_time, rec_id FROM aas_callservices";

$result=mysql_query($query) or die(mysql_error());

//echo 'Call Request Received: userId is '.$userId.' and idType is '.$idType.' and name is '.$name.' and contactNumber is '.$contactNumber.' and carMake is '.$carMake.' and carModel is '.$carModel.' and carColor is '.$carColor.' and carNumber is '.$carNumber.' and lat is '.$lat.' and lng is '.$lng.' and address is '.$address.' and note is '.$note;

$display_fields=array('userId', 'rec_id', 'status');

$content="<table border=\"1\">";

while($row = mysql_fetch_array($result))
{

    $content = $content . "<tr>";
    foreach($display_fields as $key)
    {
        $content = $content . "<td>" . $row[$key] . "</td>";
    }
    $content = $content . "</tr>";
}
$content=$content."</table>";

echo $content;

mysql_close();



?>