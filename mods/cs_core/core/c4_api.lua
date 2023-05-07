c4 = {
    planter = "none",
    pos = {x=1,y=1,z=1},
	planted = false,
    timer = 0,

}
c4c = {
    radio = 60,
    damage = 10,
    dist = 70,
    depend_on_range = false,
	enable_deco = true,
}
function c4.get_planter()
	return c4.planter or "no one"
end
function c4.plant_bomb_at(pos, player)
    if pos and Name(player) then
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
        has_bomb = nil
        c4.planter = player
        bank.player_add_value(player, 50)
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
	bank.player_add_value(c4.planter, 200)
    local v3d = table.copy(vector)
    local distance = c4c.dist
    local radius = c4c.radio
    local pos = c4.pos
    local p1 = v3d.subtract(pos, radius)
	local p2 = v3d.add(pos, radius)
    if c4c.enable_deco then
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
			local obj_pos = obj:get_pos()
			local dist = v3d.distance(obj_pos, pos)
			local damage = c4c.damage
			if dist ~= 0 then
				obj_pos.y = obj_pos.y + 1
				local blast_pos = {x=pos.x, y=pos.y + 4, z=pos.z}
						--minetest.line_of_sight(obj_pos, blast_pos, 1)
						--print(obj)
						if type(obj) ~= "string" and obj:get_player_name() ~= "" and Player(c4.planter) then
							obj:punch(Player(c4.planter), nil, { damage_groups = {fleshy=damage}, }, nil)
						end
			end
	end
	c4.planted = false

end

-- Beep when the bomb is on
function hooks(dtime)
	c4.timer = c4.timer + dtime
	if c4.planted == true then
		
		-- Increase the beeps when the time is less.
		if time > 90 and time < 120 then
			time_to = 0.8
		end
		if time > 60 and time < 100 then
			time_to = 0.7
		end
		if time > 30 and time < 50 then
			time_to = 0.5
		end
		if time > 10 and time < 30 then
			time_to = 0.3
		end
		if time > 5 and time < 10 then
			time_to = 0.1
		end
		
		if time > 120 then
			time_to = 1
		end
		
		if not time_to then
			time_to = 0.9
		end
		
		if c4.timer >= time_to then
			play_sound()
			c4.timer = 0
			--minetest.sound_fade(handle, 1, 0.1)
		end
	end
end
function play_sound()
	for _, player in pairs(minetest.get_objects_inside_radius(c4.pos, 32)) do
		if player:get_player_name() ~= "" or  player:get_player_name() ~= " " then
			local dist = vector.distance(Player(player):get_pos(), c4.pos)
			local gain = (32 - dist) / 32
			local gain_value = gain * 1.0
			if not (gain <= 0) then
				minetest.sound_play({name = "cs_files_beep"}, {to_player = Name(player), gain = gain_value})
			end
		end
	end
end

core.register_globalstep(hooks)

call.register_on_new_match(function()
	if c4.planted then
		c4.remove_bomb2()
		time_to = 1
	end
end)



