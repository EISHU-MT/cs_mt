c4 = {
    planter = "none",
    pos = {x=1,y=1,z=1},
	planted = false,
    timer = 0,

}
-- CLua Tools.
clua.register_table("c4", {
    clua_loaded = true,
    radio = 60,
    damage = 10,
    dist = 70,
    depend_on_range = false,
	enable_deco = true,
})
--clua.using(math)
function c4.get_planter()
	return c4.planter or "no one"
end
function c4.plant_bomb_at(pos, player)
    if pos and clua.pname(player) then
		if type(pos) ~= "table" then
			error("c4.plant_bomb_at(): no table of position are found! or just a string...")
		end
        core.after(1, function(pos)
        	pos.y = pos.y + 1 -- Fix bug
            core.set_node(pos, {name="c4", param1=1, param2=1})
            for _, p in pairs(core.get_connected_players()) do
                pname = p:get_player_name()
                
                hud_events.new(p, {
			text = ("(!) The bomb is planted!"),
			color = "warning",
			quick = false,
               })
               
            end
        end, pos)
        time = 120
        ctimer.on_end_type("c4")
        c4.planter = player
        c4.pos = pos
		c4.planted = true
    end
end
function c4.remove_bomb2()
	minetest.set_node(c4.pos, {name="air"})
	c4.planted = false
	c4.planter = "none"
	c4.pos = {x=0, y=0, z=0}
end
function c4.remove_bomb()
	minetest.set_node(c4.pos, {name="air"})
end
function c4.get_status()
	return c4.planted
end
function c4.bomb_now()
    -- This code is not official written by EISHU, its a copy of a mod `shooter`
	if c4.get_status() == false then
		return
	end
    local v3d = table.copy(vector)
    local distance = clua.get_int("dist", clua.get_table_value("c4"))
    local radius = clua.get_int("radio", clua.get_table_value("c4"))
    local pos = c4.pos
    local p1 = v3d.subtract(pos, radius)
	local p2 = v3d.add(pos, radius)
    if clua.get_bool("enable_deco", clua.get_table_value("c4")) then
		minetest.add_particlespawner({
			amount = 300,
			time = 0.1,
			minpos = p1,
			maxpos = p2,
			minvel = {x=0, y=0, z=0},
			maxvel = {x=0, y=0, z=0},
			minacc = {x=-0.5, y=5, z=-0.5},
			maxacc = {x=0.5, y=5, z=0.5},
			minexptime = 0.5,
			maxexptime = 2,
			minsize = 40,
			maxsize = 95,
			collisiondetection = false,
			texture = "smoke.png",
		})
	end
	--p(core)
	local objects = minetest.get_objects_inside_radius(pos, distance)
	for _,obj in ipairs(objects) do
		if clua.is_punchable_obj(obj) then
			local obj_pos = obj:get_pos()
			local dist = v3d.distance(obj_pos, pos)
			local damage = clua.get_int("damage", clua.get_table_value("c4")) --(fleshy * 0.5 ^ dist) * 2 * config.damage_multiplier
			if dist ~= 0 then
				obj_pos.y = obj_pos.y + 1
				local blast_pos = {x=pos.x, y=pos.y + 4, z=pos.z}
				if clua.is_punchable_obj(obj) and
						minetest.line_of_sight(obj_pos, blast_pos, 1) then
							--print(obj)
						if type(obj) ~= "string" then
                        	obj:punch(core.get_player_by_name(c4.planter), nil, { damage_groups = {fleshy=damage}, }, nil)
						end
				end
			end
		end
	end
	c4.planted = false
end
-- the most important code:
call.register_on_new_match(function()
	if ask_for_bomb() then
		i = 0
		for pname in pairs(csgo.team.terrorist.players) do
			i = i + 1
			core.debug("green", "Register_On_New_Match(): adding "..pname.." to the list... Value: "..i, "C4 API")
		end
		local r = math.random(1, i)
		pname = csgo.team.terrorist.players[r]
		if not pname then
			return
		end
		core.debug("green", "Giving the bomb to a random player ("..pname..")", "C4 API")
		Player = clua.player(pname)
		if not clua.find_itemstack_from(clua.player(pname), "bomb") then
			InvRef = Player:get_inventory()
			InvRef:add_item("main", "bomb")
		end
	end
end)

-- Beep when the bomb is on
function hooks(time)
	c4.timer = c4.timer + time
	print("a")
	if c4.planted == true then
		print("b")
		if c4.timer >= 1 then
			print("c")
			minetest.sound_play("cs_files_beep", {pos = c4.pos, gain = 0.5, max_hear_distance = 60})
			c4.timer = 0
		end
	end
end

core.register_globalstep(hooks)





