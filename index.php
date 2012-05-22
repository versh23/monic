<?
include_once('model.php');
if(isset($_GET['id']))
{	
	//если передана какая то чушь - редирект на главную
	if(!is_numeric($id)) header('Location: http://tmxxi.ru/tmgroup/');
	$row=get_content($_GET['id']);	
}else{
$row=get_content(37);	
include_once('head.tpl');
include_once('main_content.tpl');
include_once('footer.tpl');
}
include_once('head.tpl');
include_once('content.tpl');
include_once('footer.tpl');
