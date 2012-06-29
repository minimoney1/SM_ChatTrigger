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
	decl String:pTrig[8], String:sTrig[8];
	ChatTrigger_GetPublicString(pTrig, sizeof(pTrig));
	ChatTrigger_GetSilentString(sTrig, sizeof(sTrig));
	PrintToChatAll("\x03Type %ssettings or %ssettings in chat to open your settings menu!", pTrig, sTrig);
}