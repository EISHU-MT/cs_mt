-- Registers bomb
dropt_bomb_pos = nil
dropt_bomb_handler = ""
local S = minetest.get_translator("core")
minetest.register_craftitem(":bomb", {
	description = S("C4 | only terrorists can had this."),
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
						text = S("(!) The bomb cant be placed here!"),
						color = "warning",
						quick = true,
					})
				end
			end
		else
			hud_events.new(player, {
				text = S("(!) The bomb cant be planted on a map that had the bomb_planting disabled"),
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
			temporalhud[pnamee] = player:hud_add({
				hud_elem_type = "waypoint",
				number = 0xFF6868,
				name = "Dropped bomb is here! dropt by ".. drp:get_player_name(),
				text = "m",
				world_pos = obj:get_pos()
			})
			hud_events.new(Player(pnamee), {
				text = ("(!) The bomb is being dropped!"),
				color = "warning",
				quick = false,
			})
		end
		has_bomb = nil
		
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
					local player = Player(pnamee)
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
		table.ref:remove()
	end,
})
minetest.register_node(":c4", {
    description = S("C4 Node\nIf hading this while playing will be reported."),
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
	if type(temporalhud) == "table" and dropt_bomb_object then
		player = Player(pnamee)
		if player and not csgo.pot[Name(lname)] == "counter" then
			if player:hud_get(temporalhud[pnamee]) then
				player:hud_remove(temporalhud[pnamee])
				temporalhud[pnamee] = nil
				--core.log("green", "On_Pickup(): Bomb: removing hud of the player "..pnamee.." hud: bomb_waypoint.", "C4 API")
			end
		end
		dropt_bomb_object:remove()
	end
end

call.register_on_new_match(func)














