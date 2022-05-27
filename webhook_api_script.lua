local webhook_api = {}

local HttpService = game:GetService("HttpService")

local proxy = "https://webhook.lewistehminerz.dev/api/webhooks/"
local webhook = nil
local WEBHOOK_ID = nil
local WEBHOOK_TOKEN = nil

webhook_api.CreateMessage = function(sent)
	HttpService:PostAsync(webhook,HttpService:JSONEncode(
		{
			content = sent
		}
		))
end

webhook_api.CreateEmbed = function(title,sent,image,color)
	local data = {
		['content'] = "",
		['embeds'] = {{
			['author'] = {
				['name'] = title,
				['icon_url'] = image,
			},
			['description'] = sent,
			['type'] = "rich",
			["color"] = tonumber(color),
		}}
	}	
	local encodedData = HttpService:JSONEncode(data)
	HttpService:PostAsync(webhook,encodedData)
end

webhook_api.SetWebhook = function(id,token)
	WEBHOOK_ID = id
	WEBHOOK_TOKEN = token
	webhook = proxy..WEBHOOK_ID.."/"..WEBHOOK_TOKEN
end

return webhook_api
