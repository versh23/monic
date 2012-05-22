<?php

error_reporting(0);



$timeout = 1; // The connection timeout, in seconds


if( $server = fsockopen( "udp://".$server, $errno, $errstr ) )
{
socket_set_timeout($server,$timeout);    
$write = "\xFF\xFF\xFF\xFFTSource Engine Query\x00";
    socket_set_timeout($server,$timeout);
    fwrite($server, $write);
    $server_response = fread($server,4096);
    fclose($server);
    $server_status = ($server_response ? 'ON' : 'OFF');
    if ($server_status == "ON"){
        $server_info['server_type'] = $server_response[4];
        $server_response = substr($server_response, 5);
        if ($server_info['server_type'] == "m") {
            $server_info['address'] = cs_get_value_string($server_response);
            $server_info['hostname'] = htmlentities(cs_get_value_string($server_response));
            $server_info['map'] = cs_get_value_string($server_response);
            $server_info['gamedir'] = cs_get_value_string($server_response);
            $server_info['description'] = cs_get_value_string($server_response);
            $server_info['players'] = cs_get_value_byte($server_response);
            $server_info['max'] = cs_get_value_byte($server_response);
            $server_info['protocol'] = cs_get_value_byte($server_response);
            $server_info['lan'] = cs_get_value_byte($server_response);
            $server_info['os'] = $server_response[0];
            $server_response = substr($server_response, 1);
            $server_info['password'] = cs_get_value_byte($server_response);
            $server_info['is_mod']     = cs_get_value_byte($server_response);
            $server_info['url_info'] = cs_get_value_string($server_response);
            $server_info['url_down'] = cs_get_value_string($server_response);
            $server_info['unused'] = cs_get_value_string($server_response);
            $server_info['mod_version'] = cs_get_value_lint($server_response);
            $server_info['mod_size'] = cs_get_value_lint($server_response);
            $server_info['sv_only'] = cs_get_value_byte($server_response);
            $server_info['cl'] = cs_get_value_byte($server_response);
            $server_info['secure'] = cs_get_value_byte($server_response);
            $server_info['bots'] = cs_get_value_byte($server_response);
            $typeimg = ".gif";
            $type = "cs";
        }
        elseif ($server_info['server_type'] == "I") {
            $server_info['address'] = $ip.":".$port;
            $server_info['protocol'] = cs_get_value_byte($server_response);
            $server_info['hostname'] = htmlentities(cs_get_value_string($server_response));
            $server_info['map'] = cs_get_value_string($server_response);
            $server_info['gamedir'] = cs_get_value_string($server_response);
            $server_info['description'] = cs_get_value_string($server_response);
            $server_info['app_id'] = cs_get_value_sint($server_response);
            $server_info['players'] = cs_get_value_byte($server_response);
            $server_info['max'] = cs_get_value_byte($server_response);
            $server_info['bots'] = cs_get_value_byte($server_response);
            $server_info['lan'] = cs_get_value_byte($server_response);
            $server_info['os'] = cs_get_value_string($server_response);
            $server_info['password'] = cs_get_value_byte($server_response);
            $server_info['secure'] = cs_get_value_byte($server_response);
            $server_info['version'] = cs_get_value_string($server_response);
            $typeimg = ".gif";
            $type = "css";
        }
    }
}
else $server_status = "OFF";

function cs_get_value_string(&$data) {
    $temp = '';
    $i = 0;
    while (ord($data[$i]) != 0){
        $temp .= $data[$i];
        $i++;
    }
    $data = substr($data, $i+1);
    return $temp;
}

function cs_get_value_byte(&$data) {
    $temp = $data[0];
    $data = substr($data, 1);
    return ord($temp);
}

function cs_get_value_lint(&$data) {
    $temp = substr($data, 0, 4);
    $data = substr($data, 4);
    $array = @unpack('Lint', $temp);
    return $array['int'];
}

function cs_get_value_sint(&$data) {
    $tmp = substr($data, 0, 2);
    $data = substr($data, 2);
    $array = @unpack('Sshort', $tmp);
    return $array['short'];
}

if (strlen($server_info['hostname']) > 100 ) 
$online_s='<center>
<font size="3" face="tahoma" color="red">'.$game.'</b>Идет игра...</font>
</center>';
echo $online_s;

?>
