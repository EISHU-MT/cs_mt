minetest.register_on_prejoinplayer(function(name, ip)
	if tostring(name):find("__") or tostring(name):find("DST") then
		return "Name cannot contain \"__\" or \"DST\" because that are reserved for developers purposes!"
	end
end)
