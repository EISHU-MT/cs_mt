--[[
	EISHU: "Might have to nuke here when selectable nametags exist >:("
	Dynamic nametags! JSJSJSJS
--]]
-- Example: dnametag.exampleOBJ = {obj = obj, name = "", range = 50, players = {usrdata1, usrdata2}, color = 0x0000, huds = {pname1 = ID}}
dnametag = {

}

dnt_api = {}

dnthud = {
	hud_elem_type = "waypoint",
	number = 0x00,
	name = "",
	text = "",
	world_pos = vector.new()
}

local function is_online(thing)
	if type(thing) == "userdata" then
		if thing:is_player() and thing:get_player_name() and thing:get_player_control() then
			return true
		else
			return false
		end
	else
		return Player(thing) ~= nil
	end
end

local function on_step(dtime)
	for i, nt in pairs(dnametag) do
		if nt.obj:get_yaw() and nt.name and nt.players then
			for _, player in pairs(nt.players) do
				if is_online(player) then
					if nt.range then
						if vector.distance(nt.obj:get_pos(), player:get_pos()) <= nt.range then
							if nt.huds[Name(player)] then
								player:hud_change(nt.huds[Name(player)], "world_pos", nt.obj:get_pos())
							else
								local def = dnthud
								def.world_pos = nt.obj:get_pos()
								def.name = nt.name
								def.number = nt.color
								local id = player:hud_add(def)
								if id then
									dnametag[i].huds[Name(player)] = id
								end
							end
						else
							if nt.huds[Name(player)] then
								player:hud_remove(nt.huds[Name(player)])
								dnametag[i].huds[Name(player)] = nil
							end
						end
					else
						if nt.huds[Name(player)] then
							player:hud_change(nt.huds[Name(player)], "world_pos", nt.obj:get_pos())
						else
							local def = dnthud
							def.world_pos = nt.obj:get_pos()
							def.name = nt.name
							def.number = nt.color
							local id = player:hud_add(def)
							if id then
								dnametag[i].huds[Name(player)] = id
							end
						end
					end
				else
					dnametag[i].players[_] = nil -- Delete player if not online
				end
			end
		end
	end
end

core.register_globalstep(on_step)

core.register_on_leaveplayer(function(thing)
	for i, nt in pairs(dnametag) do
		if nt.players then
			for _, player in pairs(nt.players) do
				if Name(player) == Name(thing) then
					dnametag[i].players[_] = nil
				end
			end
		end
		if nt.huds[Name(thing)] then
			dnametag[i].huds[Name(thing)] = nil
		end
	end
end)

function dnt_api.register_nametag(name, def)
	if name and def.name and def.obj and def.players and def.color then
		if dnametag[name] == nil then
			dnametag[name] = {
				name = def.name,
				obj = def.obj,
				color = def.color,
				players = def.players,
				range = def.range or nil,
				huds = {}
			}
		else
			return false
		end
	else
		return false
	end
end

function dnt_api.insert_player(name, player)
	if dnametag[name] then
		table.insert(dnametag[name].players, Player(player))
	end
end

function dnt_api.update_hard_players(name, players)
	if dnametag[name] then
		dnametag[name].players = players
	end
end

function dnt_api.remove_player(name, thing)
	if dnametag[name] then
		for i, player in pairs(dnametag[name].players) do
			if Name(player) == Name(thing) then
				dnametag[name].players[i] = nil
			end
		end
		for i, pname in pairs(dnametag[name].huds) do
			if pname == Name(thing) then
				dnametag[name].huds[i] = nil
			end
		end
	end
end

function dnt_api.remove_dynamic_nametag(name)
	if dnametag[name] then
		local huds = dnametag[name].huds
		dnametag[name] = nil
		for i, id in pairs(huds) do
			for i, player in pairs(core.get_connected_players()) do
				player:hud_remove(id)
			end
		end
	else
		return false
	end
end





