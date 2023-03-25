-- Registers bomb
minetest.register_craftitem(":bomb", {
	description = "C4\n only terrorists can had this.",
	inventory_image = "cs_files_c4.png",
	on_use = function(item, player)
		local inf = clua.get_player_inf(player)
		pos = inf.pos
		if ask_for_bomb() == true then
		
			statspawn = a_bomb_area()
			
			if pos.x < statspawn.x + 7 and pos.x > statspawn.x - 7 and pos.y < statspawn.y + 7  and pos.y > statspawn.y - 7 and pos.z < statspawn.z + 7 and pos.z > statspawn.z - 7 then
				if inf.pos then
					c4.plant_bomb_at(inf.pos, inf.name)
				end
			else
				statspawn = b_bomb_area()
				if pos.x < statspawn.x + 7 and pos.x > statspawn.x - 7 and pos.y < statspawn.y + 7 and pos.y > statspawn.y - 7 and pos.z < statspawn.z + 7 and pos.z > statspawn.z - 7 then
					if inf.pos then
						c4.plant_bomb_at(inf.pos, inf.name)
					end
				else
					hud_events.new(player, {
						text = "(!) The bomb cant be placed here!",
						color = "warning",
						quick = true,
					})
				end
			end
		else
			hud_events.new(player, {
				text = "(!) The bomb cant be planted on a map that had the bomb_planting disabled",
				color = "danger",
				quick = true,
			})
		end
	end,
	on_drop = function(itm, drp, pos)
		--pname = clua.pname(drp)
		if type(temporalhud) == "table" then
			return
		end
		temporalhud = {}
		
		for pnamee in pairs(csgo.team.terrorist.players) do
			player = clua.player(pnamee)
			temporalhud[pnamee] = player:hud_add({
				hud_elem_type = "waypoint",
				number = 0xFF6868,
				name = "Dropped bomb is here! dropt by ".. drp:get_player_name(),
				text = "m",
				world_pos = pos
			})
		end
		core.item_drop(itm, drp, pos)
		return "bomb -1"
	end,
	on_pickup = function(_, lname, table)
		if type(temporalhud) == "table" then
			for pnamee in pairs(temporalhud) do
				player = clua.player(pnamee)
				if player:hud_get(temporalhud[pnamee]) then
					player:hud_remove(temporalhud[pnamee])
					temporalhud[pnamee] = nil
					local inv = lname:get_inventory()
					inv:add_item("main", ItemStack("bomb"))
					core.debug("green", "On_Pickup(): Bomb: removing hud of the player "..pnamee.." hud: bomb_waypoint.", "C4 API")
				end
			end
		end
		temporalhud = nil
		table.ref:remove()
	end,
})
minetest.register_node(":c4", {
    description = "C4 Node\nIf hading this while playing will be reported to CLua.",
    tiles = {"bomb_3.png", "bomb_1.png", "bomb_2.png"},
    groups = {immortal=1},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {-0.5, -0.4, -0.3, 0.2, 0, 0.7},
    },
    on_place = function(itemstack, placer, pointed_thing)
        clua.handle_error("type:1", "tell:discord", "error:A player "..placer:get_player_name().." placed a prohibited node.")
        clua.throw("The node `c4` cant be proccesed by CS:GO!")
    end,
})