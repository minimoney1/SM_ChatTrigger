#pragma semicolon 1

#include <sourcemod>
#include <chat_triggers>


public Plugin:myinfo = 
{
	name = "Chat Triggers Test",
	author = "mINI",
	description = "",
	version = "1.0.0",
	url = ""
}

public OnMapStart()
{
	CreateTimer(10.0, Timer_Spam, _, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
}

public Action:Timer_Spam(Handle:timer)
{
	PrintToChatAll("\x03Type %csettings to open your settings menu!", ChatTrigger_GetPublic());
}