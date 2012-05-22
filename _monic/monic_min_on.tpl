<? 
$back = (file_exists('maps/cs/'.$map.'.gif'))? 'maps/cs/'.$map.'.gif' : 'maps/off.gif';
?>
<html>
<META HTTP-EQUIV="refresh" CONTENT="120; url=<?=$url?>">
<body>
<center>
<table cellpadding="0" cellspacing="0">
    <tr>
        <td background="<?=$back;?>">
            <img border="0" src="maps/map.gif" width="160" height="119">			
        </td>
    </tr>
</table>
Игроки: <strong><?=$cnt?>/20</strong> <br />
Карта: <strong><?=$map?></strong><br/>
Статус сервера: <font color="green"><b>ON</b></font>
</center>
</body>
</html>
