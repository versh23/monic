<?php
function to_normal_name(&$str)
{
	$str=str_replace ('ap1', '`',$str);
	$str=str_replace ('ap2', "'",$str);
	$str=iconv("UTF-8", "windows-1251", $str);
	$str=htmlspecialchars($str);
	return $str;	
}
function db_search_f($host,$login,$pass,$sid)
{
	$link=mysql_connect($host,$login,$pass) or die('No connect to database');	
	mysql_select_db('web913612_forum') or die('no connetc to database');	
	$normal_sid=dscrypt($sid,1);
	$query = sprintf("SELECT ibf_srr_hdd.forum_id FROM ibf_srr_steam INNER JOIN ibf_srr_hdd ON ibf_srr_steam.hddsn = ibf_srr_hdd.hddsn WHERE ibf_srr_steam.steam = '%s' LIMIT 1",mysql_real_escape_string($normal_sid));
	//die ($query);
	$res=mysql_query($query);
	if(!$res) die("Ошибка запроса");
	if(!mysql_num_rows($res)) die('нет связи игрока с форумом');
	$id = mysql_result($res,0,0);
	mysql_close($link);
	return $id;
}

function db_search_s($host,$login,$pass,$sid)
{
	$link=mysql_connect($host,$login,$pass) or die('No connect to database');
	mysql_select_db('web913612_ps') or die('no connetc to database');	
	$normal_sid=dscrypt($sid,1);
	$query = sprintf("SELECT `plrid` FROM `ps_plr_ids_worldid` WHERE `worldid` = '%s'",mysql_real_escape_string($normal_sid));
	$res=mysql_query($query);
	if(!$res) die("Ошибка запроса");
	if(!mysql_num_rows($res)) die('нет связи игрока со статистикой');
	$id = mysql_result($res,0,0);
	mysql_close($link);
	return $id;
}

function dsCrypt($input,$decrypt=false) {
    $o = $s1 = $s2 = array();   
    $basea = array('?','(','@',';','$','#',"]","&",'*'); 
    $basea = array_merge($basea, range('a','z'), range('A','Z'), range(0,9) );
    $basea = array_merge($basea, array('!',')','_','+','|','%','/','[','.',' ') );
    $dimension=9;
    for($i=0;$i<$dimension;$i++) {
        for($j=0;$j<$dimension;$j++) {
            $s1[$i][$j] = $basea[$i*$dimension+$j];
            $s2[$i][$j] = str_rot13($basea[($dimension*$dimension-1) - ($i*$dimension+$j)]);
        }
    }
    unset($basea);
    $m = floor(strlen($input)/2)*2; 
    $symbl = $m==strlen($input) ? '':$input[strlen($input)-1];
    $al = array();
    
    for ($ii=0; $ii<$m; $ii+=2) {
        $symb1 = $symbn1 = strval($input[$ii]);
        $symb2 = $symbn2 = strval($input[$ii+1]);
        $a1 = $a2 = array();
        for($i=0;$i<$dimension;$i++) {
            for($j=0;$j<$dimension;$j++) {
                if ($decrypt) {
                    if ($symb1===strval($s2[$i][$j]) ) $a1=array($i,$j);
                    if ($symb2===strval($s1[$i][$j]) ) $a2=array($i,$j);
                    if (!empty($symbl) && $symbl===strval($s2[$i][$j])) $al=array($i,$j);
                }
                else {
                    if ($symb1===strval($s1[$i][$j]) ) $a1=array($i,$j);
                    if ($symb2===strval($s2[$i][$j]) ) $a2=array($i,$j);
                    if (!empty($symbl) && $symbl===strval($s1[$i][$j])) $al=array($i,$j);
                }
            }
        }
        if (sizeof($a1) && sizeof($a2)) {
            $symbn1 = $decrypt ? $s1[$a1[0]][$a2[1]] : $s2[$a1[0]][$a2[1]];
            $symbn2 = $decrypt ? $s2[$a2[0]][$a1[1]] : $s1[$a2[0]][$a1[1]];
        }
        $o[] = $symbn1.$symbn2;
    }
    if (!empty($symbl) && sizeof($al))
        $o[] = $decrypt ? $s1[$al[1]][$al[0]] : $s2[$al[1]][$al[0]];
    return implode('',$o);
}