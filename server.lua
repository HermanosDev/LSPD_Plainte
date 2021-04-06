local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/828964320280576021/4zz7SunM00DYzdDmI1pvvw8xRJIjuUewQoB5Km369W0Y7PafcdLmjOMptNw3W1528Ll9"
local DISCORD_NAME = "Centrale LSPD"
local DISCORD_IMAGE = "https://i.imgur.com/rnMbgUi.png"


function GetIDFromSource(Type, ID)
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Centrale LSPD - 2020/2021",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end



RegisterServerEvent('plaintelspd')
AddEventHandler('plaintelspd',function(message)
    sendToDiscord("Centrale LSPD", '```' ..message.. '```', 16711680)
end)
