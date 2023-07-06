-- Registers bomb
dropt_bomb_pos = nil
dropt_bomb_handler = ""
local S = minetest.get_translator("core")

function process_str(str)
	local words = {}
	for word in str:gmatch("%w+") do
		table.insert(words, word)
	end
	return words
end

process_string = process_str

minetest.register_craftitem(":bomb", {
	description = S("C4 | only terrorists can have the bomb."),
	inventory_image = "cs_files_c4.png",
	on_use = function(item, player)
		local inf = {pos = player:get_pos(), name = player:get_player_name(), inv = player:get_inventory()}
		pos = inf.pos
		if ask_for_bomb() == true then
		
			statspawn = a_bomb_area()
			
			if pos.x < statspawn.x + 7 and pos.x > statspawn.x - 7 and pos.y < statspawn.y + 7  and pos.y > statspawn.y - 7 and pos.z < statspawn.z + 7 and pos.z > statspawn.z - 7 then
				if inf.pos then
					c4.plant_bomb_at(inf.pos, inf.name)
					inf.inv:remove_item("main", item) -- Fix ridiculous bug
				end
			else
				statspawn = b_bomb_area()
				if pos.x < statspawn.x + 7 and pos.x > statspawn.x - 7 and pos.y < statspawn.y + 7 and pos.y > statspawn.y - 7 and pos.z < statspawn.z + 7 and pos.z > statspawn.z - 7 then
					if inf.pos then
						c4.plant_bomb_at(inf.pos, inf.name)
						inf.inv:remove_item("main", item) -- Fix ridiculous bug
					end
				else
					hud_events.new(player, {
						text = S("(!) The bomb can't be placed here!"),
						color = "warning",
						quick = true,
					})
				end
			end
		else
			hud_events.new(player, {
				text = S("(!) bomb_planting is disabled"),
				color = "danger",
				quick = true,
			})
		end
	end,
	on_drop = function(itm, drp, pos)
		--pname = clua.pname(drp)
		if type(temporalhud) == "table" then
			return "bomb -1"
		end
		
		if has_bomb and has_bomb ~= Name(drp) then
			return "bomb -1"
		end
		
		--core.item_drop(ItemStack("bomb"), drp, pos)
		
		local pos = player:get_pos()
		pos.y = math.floor(pos.y + 0.5)
		local obj = minetest.add_item(pos, itm)
		obj:set_velocity({ x = math.random(-1, 1), y = 5, z = math.random(-1, 1) })
		dropt_bomb_object = obj
		dropt_bomb_pos = pos
		dropt_bomb_handler = Name(drp)
		
		temporalhud = {}
		
		for pnamee in pairs(csgo.team.terrorist.players) do
			local player = Player(pnamee)
			temporalhud[pnamee.." "..FormRandomString(5)] = player:hud_add({
				hud_elem_type = "waypoint",
				number = 0xFF6868,
				name = "Bomb was dropped! dropped by ".. drp:get_player_name(),
				text = "m",
				world_pos = obj:get_pos()
			})
			hud_events.new(Player(pnamee), {
				text = ("(!) The bomb has been dropped!"),
				color = "warning",
				quick = false,
			})
		end
		has_bomb = nil
		bomb_holder = ""
		return ItemStack("")
	end,
	on_pickup = function(_, lname, table)
		if csgo.check_team(Name(lname)) ~= "terrorist" then
			return false
		end
		if type(temporalhud) == "table" then
			if has_bomb == nil then
				--error()
				for pnamee, id in pairs(temporalhud) do
					local player = Player(process_string(pnamee)[1])
					if player then
						---error()
						--if player:hud_get(temporalhud[pnamee]) then
							player:hud_remove(id)
							temporalhud[pnamee] = nil
							--core.debug("green", "On_Pickup(): Bomb: removing hud of the player "..pnamee.." hud: bomb_waypoint.", "C4 API")
						--end
					end
				end
				local inv = lname:get_inventory()
				inv:add_item("main", ItemStack("bomb"))
				has_bomb = Name(lname)
			end
		end
		temporalhud = nil
		dropt_bomb_object = nil
		bomb_holder = lname:get_player_name()
		ReportBombPicked(Name(lname))
		table.ref:remove()
	end,
})
minetest.register_node(":c4", {
    description = S("C4 Node\nWill be reported when in possesion of C4 node."), -- the most concise version of this sentance is too long
    tiles = {"bomb.png"},
    groups = {immortal=1, falling_node = 1},
    drawtype = "mesh",
    visual_scale = 0.5,
    paramtype = "light",
    paramtype2 = "facedir",
    pointable = false,
    mesh = "bomb.obj",
    on_place = function(itemstack, placer, pointed_thing)
        print()
    end,
})

local function func()
	if type(temporalhud) == "table" then
		if dropt_bomb_object then
			for pnamee, id in pairs(temporalhud) do
				local player = Player(process_string(pnamee)[1])
				if player and not csgo.pot[Name(lname)] == "counter" then
					if player:hud_get(temporalhud[pnamee]) then
						player:hud_remove(temporalhud[pnamee])
						temporalhud[pnamee] = nil
						--core.log("green", "On_Pickup(): Bomb: removing hud of the player "..pnamee.." hud: bomb_waypoint.", "C4 API")
					end
				end
			end
			temporalhud = nil
			dropt_bomb_object:remove()
			dropt_bomb_object = nil
			return
		end
	end
end

function check_if_bomb()
	for player, contents in pairs(csgo.team.terrorist.players) do
		if Inv(player):contains_item("main", "bomb") then
			return true, Player(player)
		end
	end
end


local function glbstep()
	-- Fix bomb obj 
	if cs_match.commenced_match == false then
		dropt_bomb_object = nil
	end
	if dropt_bomb_object then
		if type(dropt_bomb_object) then
			if dropt_bomb_object:get_yaw() then
				-- Dont do nothing
			else -- That might be a dead object (when picked up)
				dropt_bomb_object = nil
			end
		end
	end
	if check_if_bomb() then
		if temporalhud then
			for pnamee, id in pairs(temporalhud) do
				local player = Player(process_string(pnamee)[1])
				if player and not csgo.pot[Name(lname)] == "counter" then
					if player:hud_get(temporalhud[pnamee]) then
						player:hud_remove(temporalhud[pnamee])
						temporalhud[pnamee] = nil
						--core.log("green", "On_Pickup(): Bomb: removing hud of the player "..pnamee.." hud: bomb_waypoint.", "C4 API")
					end
				end
			end
			temporalhud = nil
		end
		
		-- Animations (Bomb in back of a player or bot)
		
		local _, player = check_if_bomb()
		local objs = player:get_children()
		local corrected = false
		
		for _, obj in pairs(objs) do
			local luaentity = obj:get_luaentity()
			if luaentity and luaentity.animated_bomb_obj then
				corrected = true
			end
		end
		
		if corrected ~= true then
			local pos = player:get_pos()
			local obj = core.add_entity(pos, "c4:bomb_entity")
			
			if obj then
				obj:set_attach(player, "", vector.new(1, 9, -1.6))
				obj:set_properties({nametag = "Bomb <"..Name(player)..">"})
			end
		end
		
	else
		if temporalhud then
			local not_ok = false
			for pname, id in pairs(temporalhud) do -- Do internal process
				local player = Player(process_string(pname)[1])
				local pos = player:hud_get(id).world_pos
				if pos then
					local objs = core.get_objects_inside_radius(pos, 5)
					if objs then
						for _, obj in pairs(objs) do
							if obj:get_luaentity() then
								local ent = obj:get_luaentity()
								if ent and ent.itemstring == "bomb" then
									return -- Do nothing
								end
							end
						end
					end
				end
			end
		--	if not_ok == true then
				for pname, id in pairs(temporalhud) do
					local player = Player(process_string(pname)[1])
					if player:hud_get(temporalhud[pname]) then
						player:hud_remove(temporalhud[pname])
						temporalhud[pname] = nil
						--core.log("green", "On_Pickup(): Bomb: removing hud of the player "..pnamee.." hud: bomb_waypoint.", "C4 API")
					end
				end
				temporalhud = nil
			--end
		end
	end
end

function ReportBombPicked(usr)
	csgo.send_message(core.colorize("#FFCA4A", "Bomb have been picked up by "..usr), "terrorist")
end

call.register_on_new_match(func)
core.register_globalstep(glbstep)













