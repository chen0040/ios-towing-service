<?php

$status=$_GET['status'];

$m_host_name="localhost";
$m_username="root";
$m_password="chen0469";
$m_database="mysql";

mysql_connect($m_host_name, $m_username, $m_password) or die(mysql_error());
mysql_select_db($m_database) or die(mysql_error());

$query="SELECT userId, idType, name, contactNumber, carMake, carModel, carColor, carNumber, lat, lng, address, note, comment, status, submit_time, rec_id FROM aas_callservices WHERE status=$status";

$result=mysql_query($query) or die(mysql_error());

//echo 'Call Request Received: userId is '.$userId.' and idType is '.$idType.' and name is '.$name.' and contactNumber is '.$contactNumber.' and carMake is '.$carMake.' and carModel is '.$carModel.' and carColor is '.$carColor.' and carNumber is '.$carNumber.' and lat is '.$lat.' and lng is '.$lng.' and address is '.$address.' and note is '.$note;

$display_fields=array('userId', 'rec_id', 'status', 'lat', 'lng', 'note', 'address');

$content="{\"requests\":[";

$row_count = mysql_num_rows ($result);
$column_count=count($display_fields);

$row_index=0;
while($row = mysql_fetch_array($result))
{
    $content = $content . "{";
	$column_index=0;
    foreach($display_fields as $key)
    {
        $content = $content . "\"" . $key . "\": \"" . $row[$key] . "\"";
		if($column_index != $column_count-1)
		{
			$content=$content . ",";
		}
		$column_index=$column_index+1;
    }
    $content = $content . "}";
	
	
	if($row_index!=$row_count-1)
	{
		$content = $content . ",\n";
	}
	else
	{
		$content = $content . "\n";
	}
	$row_index++;
}
$content=$content."]}";

echo $content;

mysql_close();



?>