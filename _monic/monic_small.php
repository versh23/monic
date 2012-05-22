<?php
include('class_PQ.php');
include('cfg.php');

$server=$_GET['server'];
$table=$_GET['table'];
$url='/_monic/monic_small.php?server='.$server.'&table='.$table;
$pq = PQ::create($conf);
if($pq->query_ping($server))
{
	$link=mysql_connect($host,$login,$pass) or die('No connect to database');
	mysql_select_db('web913612_ps') or die('no connetc to database');
	$res=mysql_query("SELECT * FROM $table ORDER BY `frag` DESC");
	if(!$res) die("cant select data in $table");
	$cnt=mysql_num_rows($res)-1;//последний строка номер
	$map=mysql_result($res,$cnt,5);//название карты
	mysql_data_seek($res,0);//переводв начало
	mysql_close();
	include('monic_min_on.tpl');	
}else{
	include('monic_min_off.tpl');
}