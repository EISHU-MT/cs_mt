local storage = minetest.get_mod_storage("core")
restart = false
restartm = "This server is being restarted from operator request"
-- Restart on finish all matchs
core.register_chatcommand("queue_restart", {
	description = "Restart server on finish all matchs",
	params = "<message>",
	func = function(name, param)
        --Param is optional
        restart = true
        if param then
            restartm = param
        else
            restartm = "This server is being restarted from operator request"
        end
    end,
	privs = {server=true, core=true}
})
call.register_on_new_matches(function()
    if restart then
        core.request_shutdown(restartm)
    end
end)

do
	local strs = storage:get_string("mods")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = true
				}
		local sr = core.serialize(newtable)
		storage:set_string("mods", sr)
	end
	
	local strs = storage:get_string("admins")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = true
				}
		local sr = core.serialize(newtable)
		storage:set_string("admins", sr)
	end
	
	local strs = storage:get_string("moderator_privs")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					kick = true
				}
		local sr = core.serialize(newtable)
		storage:set_string("moderator_privs", sr)
	end
end


core.register_chatcommand("report", {
	description = "Report any bug or player",
	params = "<bug or player> <description>",
	func = function(name, param)
		local tabled = param:split(" ")
		local storage_of_reports = storage:get_string("reports")
		if tabled and tabled[1] then
			if tabled[2] then
				if storage_of_reports ~= "" or storage_of_reports ~= nil then
					local reports = core.deserialize(storage_of_reports)
					if type(reports) == "table" then
						table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					else
						reports = {}
						table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					end
					storage:set_string("reports", core.serialize(reports))
					core.chat_send_player(name, "-!- Report have been sent.")
				else
					local reports = {}
					table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					storage:set_string("reports", core.serialize(reports))
					core.chat_send_player(name, "-!- Report have been sent.")
				end
			else
				core.chat_send_player(name, "-!- Description is not provided!")
			end
		else
			core.chat_send_player(name, "-!- Name is not provided!")
		end
	end,
})

core.register_chatcommand("report", {
	description = "Report any bug or player",
	params = "<bug or player> <description>",
	func = function(name, param)
		local tabled = param:split(" ")
		local storage_of_reports = storage:get_string("reports")
		if tabled and tabled[1] then
			if tabled[2] then
				if storage_of_reports ~= "" or storage_of_reports ~= nil then
					local reports = core.deserialize(storage_of_reports)
					if type(reports) == "table" then
						table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					else
						reports = {}
						table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					end
					storage:set_string("reports", core.serialize(reports))
					core.chat_send_player(name, "-!- Report have been sent.")
				else
					local reports = {}
					table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					storage:set_string("reports", core.serialize(reports))
					core.chat_send_player(name, "-!- Report have been sent.")
				end
			else
				core.chat_send_player(name, "-!- Description is not provided!")
			end
		else
			core.chat_send_player(name, "-!- Name is not provided!")
		end
	end,
})

core.register_chatcommand("show_reports", {
	description = "Show all reports",
	params = "<nothing>",
	privs = {kick=true},
	func = function(name, param)
		local storage_of_reports = storage:get_string("reports")
		if storage_of_reports ~= "" or storage_of_reports ~= nil then
			local data = core.deserialize(storage_of_reports)
			local concat = table.concat(data, "\n")
			core.chat_send_player(name, concat)
			storage:set_string("reports", nil)
		else
			core.chat_send_player(name, "-!- Database is empty.")
		end
	end,
})

function csgo.add_moderator_priv(priv)
	if not priv then
		return false, "-!- No privilegie have been found!"
	end
	
	local newtable = {}
	for privs in pairs(core.registered_privileges) do
		newtable[privs] = true
	end
	
	if newtable[priv] == true then
		local data = storage:get_string("moderator_privs")
		local privilegies = core.deserialize(data)
		privilegies[priv] = true
		local src = core.serialize(privilegies)
		storage:set_string("moderator_privs", src)
		return true, "-!- Database have been updated!"
	else
		return false, "-!- Unknown privilegie: "..priv
	end
end

function csgo.delete_moderator_priv(priv)
	if not priv then
		return false, "-!- No privilegie have been found!"
	end
	local data = storage:get_string("moderator_privs")
	local privilegies = core.deserialize(data)
	privilegies[priv] = nil
	local src = core.serialize(privilegies)
	storage:set_string("moderator_privs", src)
	return true, "-!- Database have been updated!"
end

function csgo.get_moderator_privs()
	local data = storage:get_string("moderator_privs")
	local privilegies = core.deserialize(data)
	return privilegies
end



function csgo.set_moderator_privs(tabled)
	if tabled then
		local data = storage:get_string("moderator_privs")
		local privilegies = core.serialize(tabled)
		storage:set_string("moderator_privs", privilegies)
		return true, "-!- Database have been updated!"
	else
		return false, "-!- Something failed!"
	end
end


function csgo.grant(mode, p)
	local player = Player(p)
	local name = Name(p)
	if mode == "admin" then
		local newtable = {}
		for priv in pairs(core.registered_privileges) do
			newtable[priv] = true
		end
		minetest.set_player_privs(name, newtable)
		
		local data = storage:get_string("admins")
		local admins = core.deserialize(data)
		admins[name] = true
		local tabled = core.serialize(admins)
		storage:set_string("admins", tabled)
		
	elseif mode == "moderator" then
		local privs = csgo.get_moderator_privs()
		minetest.set_player_privs(name, privs)
		
		local data = storage:get_string("mods")
		local mods = core.deserialize(data)
		mods[name] = true
		local tabled = core.serialize(mods)
		storage:set_string("mods", tabled)
	end
end

function csgo.revoke_grant(mode, p)
	local player = Player(p)
	local name = Name(p)
	if mode == "admin" then
		minetest.set_player_privs(name, {interact=true, shout=true})
		
		local data = storage:get_string("admins")
		local admins = core.deserialize(data)
		admins[name] = nil
		local tabled = core.serialize(admins)
		storage:set_string("admins", tabled)
		
	elseif mode == "moderator" then
		minetest.set_player_privs(name, {interact=true, shout=true})
		
		local data = storage:get_string("mods")
		local mods = core.deserialize(data)
		mods[name] = nil
		local tabled = core.serialize(mods)
		storage:set_string("mods", tabled)
	end
end

core.register_chatcommand("grantprivs", {
	description = "Make moderator/admin to a player or yourself",
	params = "<admin/moderator> <name>",
	privs = {server=true},
	func = function(name, param)
		local params = param:split(" ")
		csgo.grant(params[1] or "none", params[2] or name)
	end,
})

core.register_chatcommand("revokeprivs", {
	description = "Revoke moderator/admin to a player or yourself",
	params = "<admin/moderator> <name>",
	privs = {server=true},
	func = function(name, param)
		local params = param:split(" ")
		csgo.revoke_grant(params[1] or "none", params[2] or name)
	end,
})

minetest.register_on_joinplayer(function(player)
	local name = Name(player)
	if name then
		local data = storage:get_string("mods")
		local mods = core.deserialize(data)
		
		local data2 = storage:get_string("admins")
		local admins = core.deserialize(data2)
		if mods[name] then
			local privs = csgo.get_moderator_privs()
			minetest.set_player_privs(name, privs)
		elseif admins[name] then
			local newtable = {}
			for priv in pairs(core.registered_privileges) do
				newtable[priv] = true
			end
			minetest.set_player_privs(name, newtable)
		end
	end
end)














