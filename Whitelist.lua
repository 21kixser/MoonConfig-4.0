local getRawContent = function(file)
	return game:HttpGet("https://raw.githubusercontent.com/Damcpros/MoonConfig-4.0/main/"..file)
end
local getReturningData = function(file)
	return loadstring(getRawContent("https://raw.githubusercontent.com/Damcpros/MoonConfig-4.0/main/"..file))
end
local whitelist = game:GetService("HttpService"):JSONDecode(getRawContent("data.json"))
local hashLib = getReturningData("hashLib.lua")()

local lib = {}

function lib:GetPlayerData(id)
	local whitelisted, tag, priority = false,{false,false},0
	local hash = hashLib.sha256(tostring(id))
	local tagAdded = false
	if whitelist["tags"] ~= nil then
		for i, v in pairs(whitelist["tags"]) do
			if v.userid == hash then
				tagAdded = true
				tag[1] = v.tag
				local c = tostring(v.color):split("_")
				tag[2] = (Color3.fromRGB(c[1],c[2],c[3]) or Color3.fromRGB(255,50,166))
			end
		end
	end
	if whitelist["Owner"] ~= nil then
		for i, v in pairs(whitelist["Owner"]) do
			if v.id == hash then
				priority = 2
				whitelisted = true
				if not tagAdded then
					tag[1] = "MOON OWNER"
					tag[2] = Color3.fromRGB(255,0,0):ToHex()
				end
			end
		end
	end
	if whitelist["Private"] ~= nil then
		for i, v in pairs(whitelist["Private"]) do
			if v.id == hash then
				priority = 1
				whitelisted = true
				if not tagAdded then
					tag[1] = "SP+ PRIVATE"
					tag[2] = Color3.fromRGB(170, 0, 255):ToHex()
				end
			end
		end
	end
	if whitelist["Snoopy"] ~= nil then
		for i, v in pairs(whitelist["Private"]) do
			if v.id == hash then
				priority = 1
				whitelisted = true
				if not tagAdded then
					tag[1] = "SP+ OWNER"
					tag[2] = Color3.fromRGB(5, 180, 255):ToHex()
				end
			end
		end
	end
	return whitelist, tag, priority
end

return lib
