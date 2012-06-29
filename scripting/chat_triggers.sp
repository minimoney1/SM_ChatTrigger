#pragma semicolon 1

#define PLUGIN_VERSION "1.0.0"

#include <sourcemod>
#include <chat_triggers>
#undef REQUIRE_PLUGIN
#include <updater>

// Updater Defines
#define UPDATER_URL "https://raw.github.com/minimoney1/SM_ChatTrigger/master/updater.txt"

new String:g_strCore[PLATFORM_MAX_PATH];

public Plugin:myinfo = 
{
	name = "Public/Silent Chat Trigger Natives",
	author = "Mini",
	description = "Provides Natives (And Commands) to View the Public and Silent Chat Triggers",
	version = PLUGIN_VERSION,
	url = "http://forums.alliedmods.net"
}

public APLRes:AskPluginLoad2(Handle:myself, bool:late, String:error[], err_max)
{
	CreateNative("ChatTrigger_GetPublic", Native_GetPublic);
	CreateNative("ChatTrigger_GetSilent", Native_GetSilent);
	MarkNativeAsOptional("Updater_AddPlugin");
	MarkNativeAsOptional("Updater_RemovePlugin");
	return APLRes_Success;
}

public Native_GetPublic(Handle:plugin, numParams)
{
	new Handle:kv;
	if (FileToKeyValues(kv, g_strCore))
	{
		new ml = GetNativeCell(2);
		decl String:value[ml];
		if (KvGetString(kv, "PublicChatTrigger", value, ml, ""))
		{
			if (!StrEqual(value, "", false))
			{
				SetNativeString(1, value, ml);
				return true;
			}
		}
	}
	return false;
}


public Native_GetSilent(Handle:plugin, numParams)
{
	new Handle:kv;
	if (FileToKeyValues(kv, g_strCore))
	{
		new ml = GetNativeCell(2);
		decl String:value[ml];
		if (KvGetString(kv, "SilentChatTrigger", value, ml, ""))
		{
			if (!StrEqual(value, "", false))
			{
				SetNativeString(1, value, ml);
				return true;
			}
		}
	}
	return false;
}

public OnPluginStart()
{
	CreateConVar("sm_viewtrigger_version", PLUGIN_VERSION);
	RegConsoleCmd("sm_viewtrigger", Command_ViewTrigger);
	BuildPath(Path_SM, g_strCore, sizeof(g_strCore), "configs/core.cfg");
}

public OnAllPluginsLoaded()
{
	if (LibraryExists("updater"))
	{
		Updater_AddPlugin(UPDATER_URL);
	}
}

public OnLibraryAdded(const String:library[])
{
	if (!strcmp(library, "updater"))
	{
		Updater_AddPlugin(UPDATER_URL);
	}
}

public OnLibraryRemoved(const String:library[])
{
	if (!strcmp(library, "updater"))
	{
		Updater_RemovePlugin();
	}
}

public Action:Command_ViewTrigger(client, args)
{
	if (args <= 0)
	{
		ReplyToCommand(client, "[SM] Usage: sm_viewtrigger <public | silent>");
		return Plugin_Handled;
	}
	
	decl String:arg[32];
	GetCmdArg(1, arg, sizeof(arg));
	switch (arg[0])
	{
		case 'p', 'P':
		{
			decl String:trigger[16];
			ChatTrigger_GetPublicString(trigger, sizeof(trigger));
			ReplyToCommand(client, "[SM] The Sourcemod public chat trigger is %s", trigger);
		}
		case 's', 'S':
		{
			decl String:trigger[16];
			ChatTrigger_GetSilentString(trigger, sizeof(trigger));
			ReplyToCommand(client, "[SM] The Sourcemod silent chat trigger is %s", trigger);
		}
		default:
		{
			ReplyToCommand(client, "[SM] Usage: sm_viewtrigger <public | silent>");
			return Plugin_Handled;
		}
	}
	return Plugin_Handled;
}