#include <amxmodx>
#include <sqlx>
#define PLUGIN "monic"
#define VERSION "1.2"
#define AUTHOR "lee"

//Database Handles
new Handle:g_dbt
//pcvar
new g_monic_host,g_monic_login,g_monic_pass,g_monic_bdname,g_monic_table,g_monic_noround

//g_var
new table[32]
new map[32]
new global_query[5600]


public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_event("SendAudio","main_exec","a","2=%!MRAD_terwin","2=%!MRAD_ctwin","2=%!MRAD_rounddraw")
	g_monic_noround=register_cvar("monic_noround", "0")
	g_monic_host=register_cvar("monic_host", "")
	g_monic_login=register_cvar("monic_login", "")
	g_monic_pass=register_cvar("monic_pass", "")
	g_monic_bdname=register_cvar("monic_bdname", "")
	g_monic_table=register_cvar("monic_table", "")
	set_task(3.0,"init_db")
}
public init_db()
{
	new host[32],login[32],pass[32],bdname[32]
	new noround;
	noround = get_pcvar_num(g_monic_noround);	
	get_pcvar_string(g_monic_host,host,31)
	get_pcvar_string(g_monic_login,login,31)
	get_pcvar_string(g_monic_pass,pass,31)
	get_pcvar_string(g_monic_bdname,bdname,31)
	get_pcvar_string(g_monic_table,table,31)	
	g_dbt =  SQL_MakeDbTuple(host, login, pass, bdname)
	set_task(20.0,"main_exec");
	if(noround == 1)
	{
		set_task(180.0,"main_exec",_,_,_,"b");
		log_amx("[MONIC] noround detected =>> %d",noround);
	}
	return PLUGIN_CONTINUE
	//set_task ( Float:time, const function[], id = 0, parameter[]="", len = 0, flags[]="", repeat = 0 )
	
}

public main_exec()
{	
	get_mapname(map,31)
	formatex( global_query, charsmax( global_query ), "TRUNCATE TABLE `%s`;INSERT INTO `%s` (`map`) VALUES ('%s')",table,table,map)		
	new online=get_playersnum() 	
	//log_amx("online = %d",online)
	if (online == 0 )
	{
		SQL_ThreadQuery(g_dbt,"QueryHandler",global_query)
		return PLUGIN_HANDLED
	}
	new add_temp[256]
	formatex( add_temp, charsmax( add_temp ), ";INSERT INTO `%s` (`name`,`sid`,`frag`, `team`) VALUES ",table)
	add(global_query,charsmax( global_query ),add_temp)
	new Players[32]
	new Count, i		
	new name[32][40],sid[32][40],frag[32],tm[32]
	get_players(Players, Count, "h") 
	if( Count == 1 ) //если один игрок
	{		
		get_user_name(Players[0],name[0],36)
		trim(name[0])
		replace_all(name[0],40,"'","ap1")
		replace_all(name[0],40,"`","ap2")
		frag[0]=get_user_frags(Players[0])
		get_user_authid(Players[i],sid[0],36)
		tm[0]=get_user_team(Players[0])
		new buffer[256]
		formatex( buffer, charsmax( buffer ), "('%s','%s',%d, %d)",name[0],sid[0],frag[0], tm[0])
		add(global_query,charsmax( global_query ),buffer)
		SQL_ThreadQuery(g_dbt,"QueryHandler",global_query)
		return PLUGIN_HANDLED
	}
	else //если больше одного
	{			
		for (i=0; i<Count; i++)
		{	
			
			//log_amx("global_query number %d -> %s",i, global_query)
			new buffer[256]
			get_user_name(Players[i],name[i],36)
			trim(name[i])
			replace_all(name[i],40,"'","ap1")
			replace_all(name[i],40,"`","ap2")
			frag[i]=get_user_frags(Players[i])
			get_user_authid(Players[i],sid[i],36)
			tm[i]=get_user_team(Players[i])			
			formatex( buffer, charsmax( buffer ), "('%s','%s',%d, %d)",name[i],sid[i],frag[i], tm[i])
			//log_amx("buffer number %d -> %s",i,buffer)
			if ((i+1)!=Count) add(buffer,charsmax( buffer ),",")
			add(global_query,charsmax( global_query ),buffer)
			
		}
		SQL_ThreadQuery(g_dbt,"QueryHandler",global_query)
		//log_amx("global_query in the end -> %s", global_query)	
	}	
	
	return PLUGIN_HANDLED
}

public QueryHandler(failstate, Handle:query, error[], errnum, data[], size, Float:queuetime)
{
	log_amx(" -->query seconds %f",queuetime)
	if (failstate)
	{
		log_amx(" --> Error code: %d (Message: ^"%s^")", errnum, error)		
		new querystring[1024]
		SQL_GetQueryString(query, querystring, 1023)
		log_amx(" --> Original query: %s", querystring)
	}
}
public plugin_end()
{
	SQL_FreeHandle(g_dbt)	
}
