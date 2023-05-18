dropondie = {}

local function drop_list(pos, inv, list)
	for _, item in ipairs(inv:get_list(list)) do
		local obj = minetest.add_item(pos, item)

		if obj then
			obj:set_velocity({ x = math.random(-1, 1), y = 5, z = math.random(-1, 1) })
		end
	end

	inv:set_list(list, {})
end

function dropondie.drop_all(player)
	local pname = player:get_player_name()
	local inv = player:get_inventory()

	if csgo.pot[pname] == "terrorist" then
		if type(temporalhud) ~= "table" then
			temporalhud = {}
			for pnamee in pairs(csgo.team.terrorist.players) do
				temporalhud[pnamee] = Player(pnamee):hud_add({
					hud_elem_type = "waypoint",
					number = 0xFF6868,
					name = "Dropped bomb is here! dropt by ".. player:get_player_name(),
					text = "m",
					world_pos = pos
				})
				hud_events.new(Player(pnamee), {
					text = ("(!) The bomb is being dropped!"),
					color = "warning",
					quick = false,
				})
			end
			has_bomb = nil
		end
	elseif csgo.pot[pname] == "counter" then
		if inv:contains_item("main", ItemStack("core:defuser")) then
			inv:remove_item("main", "core:defuser")
		end
	end

	local pos = player:get_pos()
	pos.y = math.floor(pos.y + 0.5)

	drop_list(pos, player:get_inventory(), "main")
end

function dropondie.drop_all2(player)
	local pname = player:get_player_name()
	local inv = player:get_inventory()

	if csgo.pot[pname] == "terrorist" then
		if inv:contains_item("main", ItemStack("bomb")) then
			has_bomb = nil
			if csgo.team.terrorist.count - 1 >= 1 then
				if type(temporalhud) ~= "table" then
					temporalhud = {}
					for pnamee in pairs(csgo.team.terrorist.players) do
						temporalhud[pnamee] = Player(pnamee):hud_add({
							hud_elem_type = "waypoint",
							number = 0xFF6868,
							name = "Dropped bomb is here! dropt by ".. player:get_player_name(),
							text = "m",
							world_pos = pos
						})
						hud_events.new(Player(pnamee), {
							text = ("(!) The bomb is being dropped!"),
							color = "warning",
							quick = false,
						})
					end
					has_bomb = nil
				end
			elseif csgo.team.terrorist.count - 1 <= 1 then
				if minetest.settings:get_bool("cs_core.enable_env_debug", false) then
					core.log("warning", "None playing! The bomb will be removed and will not be recovered again! Until a terrorist player comes.")
				end
				inv:remove_item("main", "bomb 65535")
			end
		end
	elseif csgo.pot[pname] == "counter" then
		if inv:contains_item("main", ItemStack("core:defuser")) then
			inv:remove_item("main", "core:defuser")
		end
	end

	local pos = player:get_pos()
	pos.y = math.floor(pos.y + 0.5)

	drop_list(pos, player:get_inventory(), "main")
end

	core.after(0, function()
		minetest.register_on_dieplayer(dropondie.drop_all)
		minetest.register_on_leaveplayer(dropondie.drop_all2)
	end)

