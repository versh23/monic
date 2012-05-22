<?
include('cfg.php');
include('funcl.php');
include('class_PQ.php');
$server_name = $_GET['server_name'];
$server=$_GET['server'];
$table=$_GET['table'];
$url='/_monic/monic_players.php?server='.$server.'&table='.$table.'&server_name='.$server_name;

$pq = PQ::create($conf);
if($pq->query_ping($server))
{	
	$link=mysql_connect($host,$login,$pass) or die('No connect to database');
	mysql_select_db('web913612_ps') or die('no connetc to database');
	$res=mysql_query("SELECT * FROM $table ORDER BY `frag` DESC");
	if(!$res) die("cant select data in $table");	
	$cnt=mysql_num_rows($res)-1;//последний строка номер
	include('monic_players.tpl');		
}else{
	echo 'Сервер выключен';	
}