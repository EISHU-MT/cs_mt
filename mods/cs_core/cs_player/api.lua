-- Minetest 0.4 mod: player
-- See README.txt for licensing and other information.

player_api = {}
_G.died_players = {}
-- Player animation blending
-- Note: This is currently broken due to a bug in Irrlicht, leave at 0
local animation_blend = 0

player_api.registered_models = { }

-- Local for speed.
local models = player_api.registered_models

function player_api.register_model(name, def)
	models[name] = def
end

-- Player stats and animations
local player_model = {}
local player_textures = {}
local player_anim = {}
local player_sneak = {}
player_api.player_attached = {}

function player_api.get_animation(player)
	local name = player:get_player_name()
	return {
		model = player_model[name],
		textures = player_textures[name],
		animation = player_anim[name],
	}
end

-- Called when a player's appearance needs to be updated
function player_api.set_model(player, model_name, name) -- name: Name of a player, player: ObjectRef
	--local name = player:get_player_name()
	local model = models[model_name]
	if model and player then
		if player_model[name] == model_name then
			return
		end
		
		
		player:set_properties({
			mesh = model_name,
			textures = player_textures[name] or model.textures,
			visual = "mesh",
			visual_size = model.visual_size or {x = 1, y = 1},
			collisionbox = model.collisionbox or {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
			stepheight = model.stepheight or 0.6,
			eye_height = model.eye_height or 1.47,
		})
		player_api.set_animation(player, "stand")
	else
		if player then -- Solved risky error
		player:set_properties({
			textures = {"player.png", "player_back.png"},
			visual = "upright_sprite",
			visual_size = {x = 1, y = 2},
			collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3},
			stepheight = 0.6,
			eye_height = 1.625,
		})
		end
	end
	player_model[name] = model_name
end

function player_api.set_textures(player, textures)
	
	
	
	if player then
		local model = models[player_model[player]]
		local model_textures = model and model.textures or nil
		player_textures[player] = textures or model_textures
		local temp = minetest.get_player_by_name(player)
		temp:set_properties({textures = textures,})
	end
	
	

end


function player_api.set_animation(player, anim_name, speed)
	local name = player:get_player_name()
	if player_anim[name] == anim_name then
		return
	end
	local model = player_model[name] and models[player_model[name]]
	if not (model and model.animations[anim_name]) then
		return
	end
	local anim = model.animations[anim_name]
	player_anim[name] = anim_name
	player:set_animation(anim, speed or model.animation_speed, animation_blend)
end

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_model[name] = nil
	player_anim[name] = nil
	player_textures[name] = nil
end)

-- Localize for better performance.
local player_set_animation = player_api.set_animation
local player_attached = player_api.player_attached

-- Prevet knockback for attached players
local old_calculate_knockback = minetest.calculate_knockback
function minetest.calculate_knockback(player, ...)
	if player_attached[player:get_player_name()] then
		return 0
	end
	return old_calculate_knockback(player, ...)
end

function empty() end


-- Check each player and apply animations
minetest.register_globalstep(function()
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local model_name = player_model[name]
		local model = model_name and models[model_name]
		if model and not player_attached[name] then
			local controls = player:get_player_control()
			local animation_speed_mod = model.animation_speed or 30

			-- Determine if the player is sneaking, and reduce animation speed if so
			if controls.sneak then
				animation_speed_mod = animation_speed_mod / 2
			end

			-- Apply animations based on what the player is doing
			if player:get_hp() == 0 then
				empty()
				--player_set_animation(player, "lay")
			-- Determine if the player is walking
			elseif controls.up or controls.down or controls.left or controls.right then
				if player_sneak[name] ~= controls.sneak then
					player_anim[name] = nil
					player_sneak[name] = controls.sneak
				end
				if controls.LMB or controls.RMB then
					player_set_animation(player, "walk_mine", animation_speed_mod)
				else
					player_set_animation(player, "walk", animation_speed_mod)
				end
			elseif controls.LMB or controls.RMB then
				player_set_animation(player, "mine", animation_speed_mod)
			else
				player_set_animation(player, "stand", animation_speed_mod)
			end
		end
	end
end)

local function make_everyone_dissapear()
	for i, name in pairs(died_players) do
		died_players[i]:remove()
	end
end

call.register_on_new_match(make_everyone_dissapear)
call.register_on_timer_commence(make_everyone_dissapear)

local dead_ent_init = {
	initial_properties = {
		hp_max = 100,
		physical = true,
		collide_with_objects = true,
		collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
		visual = "mesh",
		mesh = "character.b3d",
		visual_size = {x = 0.4, y = 0.4},
		textures = {"character.png"},
		is_visible = true,
	},
	on_rightclick = function(self, clicker)
				core.chat_send_player(clicker:get_player_name(), "Rightclicked in a dead player....")
			end,
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
			core.chat_send_player(puncher:get_player_name(), "Hurting a dead player.....")
		end,
}
minetest.register_entity("cs_player:dead_ent", dead_ent_init)



--{x = 162, y = 166},



