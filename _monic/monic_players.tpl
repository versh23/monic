<html>
<head>
<META HTTP-EQUIV="refresh" CONTENT="120; url=<?=$url?>">
<script type="text/javascript" src="high/highslide-full.packed.js"></script>
<link rel="stylesheet" type="text/css" href="high/highslide.css" />
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="high/highslide-ie6.css" />
<![endif]-->
<link rel="stylesheet" type="text/css" href="monic_players.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" ></script>
<script type="text/javascript">
function resi(){
if (navigator.appName != 'Microsoft Internet Explorer') {
        var newWidth = $('#content1').width() +$('#content2').width() +290 ; // width of the content + 11px margins
        //var newWidth = $('#bd').width()+80 	;
        var newHeight = ($('#bd').height()+80)/1.5; // height of the content + height of header and footer
        //var newHeight = $('#content1').height() +$('#content2').height() + 80	; // height of the content + height of header and footer
        //alert('width: ' + newWidth + 'px + height: ' + newHeight + 'px')
        var exp = window.parent.hs.getExpander();
        if (exp) exp.resizeTo(newWidth, newHeight);
    }

}
$(document).ready(function() {
setTimeout(resi, 500);
}
);
    hs.graphicsDir = 'high/graphics/';
	hs.registerOverlay({
	html: '<div class="closebutton" onclick="return hs.close(this)" title="Закрыть"></div>',
	position: 'top right',
	useOnHtml: true,
	fade: 2 });
	hs.showCredits = false;
	hs.dimmingOpacity = 0.01;
	hs.allowMultipleInstances = false;
	hs.enableKeyListener = false;
	hs.blockrightClick = true;
	hs.allowWidthReduction = false;
	hs.allowHeightReduction = true;
	hs.outlineType = 'rounded-white';	
	hs.width=80;	
	hs.minWidth=160;
	hs.useBox=true;

	</script>

</head>
<body id="bd">
<div class="header"><img src="user_comment.png">&nbsp;&nbsp;<?=$info_server['name'];?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?=$server?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?=$cnt?>/20</div>
<center>
<br>
<table id="content1">
<caption class="ter"><b>Terrorist</b></caption>
<caption>&nbsp</caption>


<!---	<tr>		<th>Имя</th><th>Фраги</th>	</tr>--->
<?while ($row=mysql_fetch_assoc($res)):?>
<?if($row['team']==1):?>

	<tr>
		<td class="rig">

			<a href="#" onclick="return hs.htmlExpand(this, { contentId: '<?=$row['id']?>', targetX: '<?=$row['id']?>href 40px', targetY: '<?=$row['id']?>href 15px'} )" class="highslide" id="<?=$row['id']?>href" ><?=to_normal_name($row['name']);?></a>
		<div class="highslide-html-content" id="<?=$row['id']?>">	
			<div class="highslide-header">				
				<?=$row['name'];?>
			</div>	
			<div class="highslide-body">
				<a target="_blank" href="search.php?type=s&amp;not_bot=<?=dsCrypt($row['sid']);?>">Статистика</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
				<a target="_blank" href="search.php?type=f&amp;not_bot=<?=dsCrypt($row['sid']);?>">Форум<a/>
			</div>
		</div>
			<noscript>
				<br /><a target="_blank" href="search.php?type=s&amp;not_bot=<?=dsCrypt($row['sid']);?>">Статистика</a><br />
				<a target="_blank" href="search.php?type=f&amp;not_bot=<?=dsCrypt($row['sid']);?>">Форум<a/>
			</noscript>
		</td>
		<td class="rig" >&nbsp
			<?=$row['frag']?>
		</td>
	</tr>	
<?endif;?>
<?endwhile;mysql_data_seek($res,0);?>
</table>
<table id="content2">
<caption class="con"><b>Counter-Terrorist</b></caption>

<caption>&nbsp </caption>

	<!---<tr>		<th>Фраги</th><th>Имя</th>	</tr>	--->
<?while ($row=mysql_fetch_assoc($res)):?>
<?if($row['team']==2):?>

	<tr>
		<td class="lef_fr" >
			<?=$row['frag']?>
		&nbsp </td>
		<td class="lef_name">
		<a href="#" onclick="return hs.htmlExpand(this, { contentId: '<?=$row['id']?>', targetX: '<?=$row['id']?>href -110px', targetY: '<?=$row['id']?>href 25px'} )" class="highslide" id="<?=$row['id']?>href" ><?=to_normal_name($row['name']);?></a>
	<div class="highslide-html-content" id="<?=$row['id']?>">
			<div class="highslide-header">				
				<?=$row['name'];?>
			</div>	
		<div class="highslide-body">
			<a target="_blank" href="search.php?type=s&amp;not_bot=<?=dsCrypt($row['sid']);?>">Статистика</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			<a target="_blank" href="search.php?type=f&amp;not_bot=<?=dsCrypt($row['sid']);?>">Форум<a/>
		</div>
	</div>
		<noscript>
			<br /><a target="_blank" href="search.php?type=s&amp;not_bot=<?=dsCrypt($row['sid']);?>">Статистика</a><br />
			<a target="_blank" href="search.php?type=f&amp;not_bot=<?=dsCrypt($row['sid']);?>">Форум<a/>
		</noscript>
		</td>
	</tr>	
<?endif;?>
<?endwhile;mysql_data_seek($res,0);?>
</table>
</center>
<p style="clear:left;" /><br />
<div class="spec">
SPECTATOR:
<?while ($row=mysql_fetch_assoc($res)):?>
<?if(($row['team']==3)||($row['team']==0)):?>
<i><u><a href="#" style="color:#CCCCCC;" onclick="return hs.htmlExpand(this, { contentId: '<?=$row['id']?>', targetX: '<?=$row['id']?>href 40px', targetY: '<?=$row['id']?>href 15px'} )" class="highslide" id="<?=$row['id']?>href" ><?=to_normal_name($row['name']);?></a></i></u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	<div class="highslide-html-content" id="<?=$row['id']?>">
			<div class="highslide-header">				
				<?=$row['name'];?>
			</div>	
		<div class="highslide-body">
			<a target="_blank" href="search.php?type=s&amp;not_bot=<?=dsCrypt($row['sid']);?>">Статистика</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			<a target="_blank" href="search.php?type=f&amp;not_bot=<?=dsCrypt($row['sid']);?>">Форум<a/>
		</div>
	</div>
		<noscript>
			<br /><a target="_blank" href="search.php?type=s&amp;not_bot=<?=dsCrypt($row['sid']);?>">Статистика</a><br />
			<a target="_blank" href="search.php?type=f&amp;not_bot=<?=dsCrypt($row['sid']);?>">Форум<a/>
		</noscript>
<?endif;?>
<?endwhile;?>
</div><br />

<hr /><center ><a style="color:#FFFF99;" href="steam://connect/<?=$server?>">Соединиться...(только для Steam)</a></center>
</body>
</html>