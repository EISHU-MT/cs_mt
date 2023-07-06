ataced = false

local def = {
	initial_properties = {
			name = "bomb",
			hp_max = 500,
			physical = true,
			collide_with_objects = true,
			collisionbox = { -0.1, -0.1, -0.1, 0.1, 0.1, 0.1 },
			selectionbox = { -0.1, -0.1, -0.1, 0.1, 0.1, 0.1, rotate = false },
			pointable = true,
			visual = "mesh",
			visual_size = {x = 1.6, y = 1.6, z = 1.6},
			mesh = "pocket_bomb.obj",
			textures = {"pocket_bomb.png"},
			colors = {},
			use_texture_alpha = false,
			--spritediv = {x = 1, y = 1},
			is_visible = true,
			makes_footstep_sound = true,
			--automatic_rotate = 0,
			automatic_face_movement_dir = false,
			--automatic_face_movement_max_rotation_per_sec = -1,
			--backface_culling = false,
			nametag = "Bomb <Unknown>",
			static_save = false,
			damage_texture_modifier = "^[brighten",
			shaded = true,
			show_on_minimap = true,
			dtimer1 = 0,
			dtimer2 = 0,
			
	},
	on_rightclick = function(self, clicker)
		local obj = self.object
		local player = obj:get_attach()
		if player then
			if player:is_player() then
				local name = Name(player)
				local inv = Inv(player)
				if inv:contains_item("main", "bomb") then
					bomb_holder = ""
					local obj2 = minetest.add_item(obj:get_pos(), ItemStack("bomb"))
					if obj2 then
						obj2:set_velocity({ x = math.random(-1, 1), y = 5, z = math.random(-1, 1) })
						core.chat_send_player(Name(player), core.colorize("#FF4A4A", "You dropped the bomb! By "..Name(clicker)))
						if type(temporalhud) ~= "table" then
							temporalhud = {}
							dropt_bomb_object = obj2
							for pnamee in pairs(csgo.team.terrorist.players) do
								if Player(pnamee) then
									temporalhud[pnamee.." "..FormRandomString(5)] = Player(pnamee):hud_add({
										hud_elem_type = "waypoint",
										number = 0xFF6868,
										name = "Dropped bomb is here! dropt by ".. name,
										text = "m",
										world_pos = obj2:get_pos()
									})
									hud_events.new(Player(pnamee), {
										text = ("(!) The bomb is being dropped!"),
										color = "warning",
										quick = false,
									})
								end
							end
							has_bomb = nil
						end
					end
				end
				self.object:remove()
			elseif player:get_properties().infotext:find("BOT") then
				local name = player:get_luaentity():get_bot_name()
				bomb_holder = ""
				local obj2 = minetest.add_item(obj:get_pos(), ItemStack("bomb"))
				if obj2 then
					obj2:set_velocity({ x = math.random(-1, 1), y = 5, z = math.random(-1, 1) })
				end
				if type(temporalhud) ~= "table" then
					temporalhud = {}
					dropt_bomb_object = obj
					for pnamee in pairs(csgo.team.terrorist.players) do
						if Player(pnamee) then
							temporalhud[pnamee.." "..FormRandomString(5)] = Player(pnamee):hud_add({
								hud_elem_type = "waypoint",
								number = 0xFF6868,
								name = "Dropped bomb is here! dropt by ".. name,
								text = "m",
								world_pos = obj:get_pos()
							})
							hud_events.new(Player(pnamee), {
								text = ("(!) The bomb is being dropped!"),
								color = "warning",
								quick = false,
							})
						end
					end
					has_bomb = nil
				end
				self.object:remove()
			end
		end
	end,
	on_step = function(self)
		local attached = self.object:get_attach()
		if attached and (attached:is_player() or bots.is_bot(attached)) then
			if check_if_bomb() or (attached:get_luaentity() and attached:get_luaentity():get_bot_name() and attached:get_luaentity():get_bot_name() == bomb_holder) then
				local players = {}
				for name in pairs(csgo.team.terrorist.players) do
					table.insert(players, Player(name))
				end
				dnt_api.register_nametag("bomb", {name="Bomb", obj=self.object, color=0xFFA84A, players=players, range=40}) -- spam
				dnt_api.update_hard_players("bomb", players)
			else
				dnt_api.remove_dynamic_nametag("bomb")
			end
		else
			self.object:remove() -- remove if not attached to anything
		end
	end,
	animated_bomb_obj = true -- Used when get_luaentity().animated_bomb_obj
}
core.register_entity(":c4:bomb_entity", def)