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
������: <strong><?=$cnt?>/<?=$info_server['maxplayers'];?></strong> <br />
�����: <strong><?=$map?></strong><br/>
������ �������: <font color="green"><b>ON</b></font>
    <?if(strlen($info_server['name']) > 100):?>
    <br>
    <center><font size="3" face="tahoma" color="red">���� ����...</font></center>
    <br>
    <?endif;?>
    <?if($hltv):?>
    <a href="steam://connect/62.140.250.2:27201" title="����������� � HLTV. ������ ��� STEAM"><b>HLTV ����������</b></a>
    <br>
    <font color="red">connect 62.140.250.2:27201</font>
    <?endif;?>
</center>
</body>
</html>
