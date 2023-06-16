minetest.register_on_prejoinplayer(function(name, ip)
	if tostring(name):find("__") or tostring(name):find("DST") or tostring(name):find("BOT_") or tostring(name):find("add_to") then
		core.log("error", "Player "..tostring(name).." tried to enter with not-allowed characters: \"__\" or/and \"DST\"")
		return "Name cannot contain \"__\", \"BOT_\" or \"DST\" because that are used by CS:MT Engine!"
	end
end)
