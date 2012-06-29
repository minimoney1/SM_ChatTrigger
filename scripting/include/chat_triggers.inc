

public SharedPlugin:__pl_chat_triggers = 
{
	name = "chat_triggers",
	file = "chat_triggers.smx",
#if defined REQUIRE_PLUGIN
	required = 1,
#else
	required = 0,
#endif
};

public __pl_chat_triggers_SetNTVOptional()
{
	MarkNativeAsOptional("ChatTrigger_GetPublicString");
	MarkNativeAsOptional("ChatTrigger_GetSilentString");
}

/**
 * 
 * @brief Gets the public chat trigger as a string
 * @param trigger The string to hold the trigger
 * @param maxlength The maxlength of the string
 * 
 * @return True on success, false otherwise
 * 
 */
native bool:ChatTrigger_GetPublicString(String:trigger[], maxlength);

/**
 * 
 * @brief Gets the silent chat trigger as a string
 * @param trigger The string to hold the trigger
 * @param maxlength The maxlength of the string
 * 
 * @return True on success, false otherwise
 * 
 */
native bool:ChatTrigger_GetSilentString(String:trigger[], maxlength);

/**
 * 
 * @brief Gets the public chat trigger as a character variable and not a string
 *
 * @note This method is not recommended at all, as it is just a mere example. Please use the above natives for full functionality.
 * 
 * @return The character found on success, '\0' if the chat trigger is not a single character or an error has occured
 * 
 */
stock ChatTrigger_GetPublic()
{
	decl String:trigger[8];
	if (ChatTrigger_GetPublicString(trigger, sizeof(trigger)))
	{
		if (strlen(trigger) == 1)
		{
			return trigger[0];
		}
	}
	return '\0';
}

/**
 * 
 * @brief Gets the silent chat trigger as a character variable and not a string
 *
 * @note This method is not recommended at all, as it is just a mere example. Please use the above natives for full functionality.
 * 
 * @return The character found on success, '\0' if the chat trigger is not a single character or an error has occured
 * 
 */
stock ChatTrigger_GetSilent()
{
	decl String:trigger[8];
	if (ChatTrigger_GetSilentString(trigger, sizeof(trigger)))
	{
		if (strlen(trigger) == 1)
		{
			return trigger[0];
		}
	}
	return '\0';
}