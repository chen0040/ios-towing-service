<?php

class DBManager
{
    protected $m_host_name;
    protected $m_username;
    protected $m_password;
    protected $m_database;
    
    public function __construct()
    {
        $this->m_host_name="localhost";
        $this->m_username="root";
        $this->m_password="chen0469";
        $this->m_database="mysql";
    }
    
    public function table_exists($table)
    {
        $this->connect();
        
        $tables=mysql_list_tables($this->m_database) or die(mysql_error());
        while(list($temp)=mysql_fetch_array($tables))
        {
            if(strtolower($temp) == strtolower($table))
            {
                return true;
            }
        }

        $this->disconnect();
        
        return false;
    }

    public function connect()
    {
        mysql_connect($this->m_host_name, $this->m_username, $this->m_password) or die(mysql_error());
    }

    public function select_database()
    {        
        mysql_select_db($this->m_database) or die(mysql_error());
    }

    public function delete_table($table_name)
    {
        $this->connect();

        $this->select_database();
        
        $query="DROP TABLE " . $table_name;
        mysql_query($query) or die(mysql_error());

        $this->disconnect();
    }

    public function create_table($table_name, $fields, $primary_key)
    {
        if($this->table_exists($table_name)==TRUE)
        {
            $this->delete_table($table_name);
        }

        $this->connect();
        $this->select_database();
        
        $query="CREATE TABLE " . $table_name . " (";
        foreach($fields as $key => $detail)
        {
                $query=$query . $key . " " . $detail . ", ";
                if($key==$primary_key)
                {
                        $query=$query . "PRIMARY KEY(" . $key . "), ";
                }
        }
        $query=substr_replace($query, ")", -2);
        //echo $query;

        mysql_query($query) or die(mysql_error());

        $this->disconnect();
    }

    public function insert_into_table($table_name, $keys, $values)
    {
        $this->connect();

        $this->select_database();
        
        $query="INSERT INTO " . $table_name . " (";
        foreach($keys as $key)
        {
            $query=$query . $key . ", ";
        }
        $query=substr_replace($query, ")", -2);
        $query=$query . " VALUES (";
        foreach($values as $value)
        {
            $query=$query . "'" . $value . "', ";
        }
        $query=substr_replace($query, ")", -2);
        //echo $query;
        mysql_query($query) or die(mysql_error());

        $this->disconnect();
    }

    private function select_from_table($table_name, $keys, $criteria)
    {
        $query="SELECT ";
        if(count($keys) == 0)
        {
            $query=$query . "*";
        }
        else
        {
            foreach($keys as $key)
            {
                $query=$query . $key . ", ";
            }
        }
        $query=substr_replace($query, "", -2);
        $query=$query . " FROM " . $table_name;
        if($criteria != "")
        {
            $query=$query . " " . $criteria;
        }
        //echo $query;
        $result=mysql_query($query) or die(mysql_error());

        return $result;
    }

    public function create_html_table($table_name, $keys, $criteria, $display_fields, $display_style)
    {
        $this->connect();

        $this->select_database();

        $data=$this->select_from_table($table_name, $keys, $criteria);
        $content="<table style=\"" . $display_style . "\" border=\"1\">";

        $content = $content . "<tr>";
        foreach($display_fields as $value)
        {
                $content = $content . "<td style=\"font-weight:bold\">" . $value . "</td>";
        }
        $content = $content . "</tr>";

        while($row = mysql_fetch_array($data))
        {

                $content = $content . "<tr>";
                foreach($display_fields as $key)
                {
                        $content = $content . "<td>" . $row[$key] . "</td>";
                }
                $content = $content . "</tr>";
        }

        $this->disconnect();
        
        $content=$content . "</table>";

        return $content;
    }

    public function disconnect()
    {
        mysql_close();
    }
}

?>