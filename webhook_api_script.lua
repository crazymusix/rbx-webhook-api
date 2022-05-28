local webhook_api = {}

local HttpService = game:GetService("HttpService")

local proxy = "https://webhook.lewistehminerz.dev/api/webhooks/"
local webhook = nil
local WEBHOOK_ID = nil
local WEBHOOK_TOKEN = nil

webhook_api.post = function(json_data)
	if webhook ~= nil then
		HttpService:PostAsync(webhook,json_data)
		return json_data	
	else
		error("Webhook wasn't found!")	
	end	
end

webhook_api.create = function(data)
	if data.has_embeds == false then
		local data_content = {
			content = data.content
		}
		local json_data = HttpService:JSONEncode(data_content)
		webhook_api.post(json_data)
		-- normal data example:
		--	local data = {
		--	content = "example",
		--}	
	else
		local data_content = 
				{
				['content'] = data.content,
				['embeds'] = {{
					['author'] = {
						['name'] = data["embedded_data"].name,
						['icon_url'] = data["embedded_data"].icon_url,
					},
					['description'] = data["embedded_data"].description,
					['type'] = data["embedded_data"].typeOfEmbed,
					["color"] = tonumber(data["embedded_data"].color),
				}}
			}
		local json_data = HttpService:JSONEncode(data_content)	
		local posted = webhook_api.post(json_data)
		print(posted)
		-- embed data example:
		--	local data = {
		--	content = "",
		--	has_embeds = true,
		--	["embedded_data"] = {
		--		name = "example",
		--		icon_url = "",
		--		description = "example text",
		--		typeOfEmbed = "rich",
		--		color = 0xff4949
		--	}
		--}		
	end
end

webhook_api.set = function(id,token)
	WEBHOOK_ID = id
	WEBHOOK_TOKEN = token
	if proxy ~= nil then
		webhook = proxy..WEBHOOK_ID.."/"..WEBHOOK_TOKEN
	else
		error("Webhook setting error: No proxy found!")
	end
	if WEBHOOK_ID ~= nil then
		webhook = proxy..WEBHOOK_ID.."/"..WEBHOOK_TOKEN
	else
		error("Webhook setting error: No webhook ID found!")
	end
	if WEBHOOK_TOKEN ~= nil then
		webhook = proxy..WEBHOOK_ID.."/"..WEBHOOK_TOKEN
	else
		error("Webhook setting error: No webhook token found!")
	end
	print(webhook)	
end

return webhook_api