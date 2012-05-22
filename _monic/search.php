<?php
include('cfg.php');
include('funcl.php');
$sid=$_GET['not_bot'];
$type=$_GET['type'];
if ($type=='f')
{
	$id=db_search_f($host,$login,$pass,$sid);
	header("Location: http://stalin-server.ru/forums/index.php?showuser=$id");
	exit;
}elseif($type=='s')
{
	$id=db_search_s($host,$login,$pass,$sid);
	header("Location: http://stalin-server.ru/psychostats/player.php?id=$id");
	exit;
}else die('ERROR');