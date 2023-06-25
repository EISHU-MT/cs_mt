player_tags = {
	objs = {},
	configs = {
		coords = {x=0, y=18, z=0},
	},
	empty = function() end,
	objs_status = {},
	funcs = {
		hide = function(user)
			if not user then return false end
			local player = Player(user)
			if player and player_tags.objs[player:get_player_name()] and (player_tags.objs_status[player:get_player_name()] ~= true) then
				player_tags.objs[player:get_player_name()]:set_properties({is_visible = false,})
				return true
			end
		end,
		show = function(user)
			if not user then return false end
			local player = Player(user)
			if player and player_tags.objs[player:get_player_name()] and (player_tags.wobjs_status[player:get_player_name()] == true) then
				player_tags.objs[player:get_player_name()]:set_properties({is_visible = true,})
				return true
			end
		end,
		return_status = function(user)
			if user and Player(user) then player_tags.empty() else return false end
			return player_tags.objs_status[Player(user):get_player_name()] or false
		end
	},
}

minetest.register_entity("cs_pt:name", {
	visual = "sprite",
	visual_size = {x=2.16, y=0.18, z=2.16},
	textures = {"invisible.png"},
	pointable = false,
	on_punch = function() return true end,
	physical = false,
	is_visible = true,
	backface_culling = false,
	makes_footstep_sound = false,
	static_save = false,
})

local function add(player, team)
	-- The hiding nametag is handled by core
	if not team then return end
	local entity = core.add_entity(Player(player):get_pos(), "cs_pt:name")
	local texture = "tag_bg.png"
	local x = math.floor(134 - ((player:get_player_name():len() * 11) / 2))
	local i = 0
	player:get_player_name():gsub(".", function(char)
		local n = "_"
		if char:byte() > 96 and char:byte() < 123 or char:byte() > 47 and char:byte() < 58 or char == "-" then
			n = char
		elseif char:byte() > 64 and char:byte() < 91 then
			n = "U" .. char
		end
		texture = texture.."^[combine:84x14:"..(x+i)..",0=W_".. n ..".png"
		i = i + 11
	end)
	texture = texture.."^[colorize:"..csgo.get_team_colour(team)..":255"
	entity:set_properties({ textures={texture} })
	entity:set_attach(player, "", player_tags.configs.coords, {x=0, y=0, z=0})
	player_tags.objs[player:get_player_name()] = entity
end

local function on_leave_player(player)
	if player and type(player_tags.objs[player:get_player_name()]) == "userdata" then
		player_tags.objs[player:get_player_name()]:remove()
	end
end

local function on_join_team(name, team)
	if name and team and team == "spectator" then
		on_leave_player(Player(name)) -- Delete nametag.
	elseif name and team then
		add(Player(name), team)
	end
end



--core.register_on_joinplayer(on_join_player)
core.register_on_leaveplayer(on_leave_player)
call.register_on_player_join_team(on_join_team)


