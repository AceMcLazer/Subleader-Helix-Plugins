local PLUGIN = PLUGIN

PLUGIN.name = "Languages"
PLUGIN.author = "Subleader"
PLUGIN.description = "Allows the player to speak in a different language."

-- Add a flag for your language
ix.flag.Add("F", "French", function(client, bGiven)
end)
ix.flag.Add("A", "Arabic", function(client, bGiven)
end)
ix.flag.Add("G", "German", function(client, bGiven)
end)
ix.flag.Add("S", "Spanish", function(client, bGiven)
end)
ix.flag.Add("I", "Italian", function(client, bGiven)
end)



-- Language function
local function CreateLangCommand (commandName, flagName, format)
	do
		local COMMAND = {}
		COMMAND.arguments = ix.type.text

		function COMMAND:OnRun(client, message)
			if client:GetCharacter():HasFlags(flagName) then
				ix.chat.Send(client, commandName, message)
				ix.chat.Send(client, commandName.."_drop", message)
			end
		end

		ix.command.Add(commandName, COMMAND)
	end

	do
		local CLASS = {}
		CLASS.color = ix.config.Get("chatColor")
		CLASS.format = "%s "..format

		function CLASS:CanHear(speaker, listener)
			return (ix.config.Get("chatRange", 280) and listener:GetCharacter():HasFlags(flagName))
		end

		ix.chat.Register(commandName, CLASS)
	end

	do
		local CLASS = {}
		CLASS.color = ix.config.Get("chatColor")
		CLASS.format = "%s "..format.." \"%s\""

		function CLASS:CanHear(speaker, listener)
			return (ix.config.Get("chatRange", 280) and !listener:GetCharacter():HasFlags(flagName))
		end
		ix.chat.Register(commandName.."_drop", CLASS)
	end
end

-- Create your language here
CreateLangCommand ("fr", "F", "says in french") -- Command, Flag, Format
CreateLangCommand ("ar", "A", "says in arabic") -- Command, Flag, Format
CreateLangCommand ("ge", "G", "says in german") -- Command, Flag, Format
CreateLangCommand ("sp", "S", "says in spanish") -- Command, Flag, Format
CreateLangCommand ("ita", "I", "says in italian") -- Command, Flag, Format