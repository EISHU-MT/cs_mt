--[[
This is not a own code of EISHU, this code was made by LandarVargan (Copy) of his ctf_kill_history (v3)



--]]
cs_kh = {}

local hud = mhud.init()

local KILLSTAT_REMOVAL_TIME = 30

local MAX_NAME_LENGTH = 19
local HUD_LINES = 6
local HUD_LINE_HEIGHT = 36
local HUDNAME_FORMAT = "kill_list:%d,%d"

local HUD_DEFINITIONS = {
	{
		hud_elem_type = "text",
		position = {x = 0, y = 0.8},
		offset = {x = MAX_NAME_LENGTH*10, y = 0},
		alignment = {x = "left", y = "center"},
		color = 0xFFF,
	},
	{
		hud_elem_type = "image",
		position = {x = 0, y = 0.8},
		image_scale = 2,
		offset = {x = (MAX_NAME_LENGTH*10) + 28, y = 0},
		alignment = {x = "center", y = "center"},
	},
	{
		hud_elem_type = "text",
		position = {x = 0, y = 0.8},
		offset = {x = (MAX_NAME_LENGTH*10) + 54, y = 0},
		alignment = {x = "right", y = "center"},
		color = 0xFFF,
	},
}

local kill_list = {}

local function update_hud_line(player, idx, new)
	idx = HUD_LINES - (idx-1)

	for i=1, 3, 1 do
		local hname = string.format(HUDNAME_FORMAT, idx, i)
		local phud = hud:get(player, hname)

		if new then
			if phud then
				hud:change(player, hname, {
					text = (new[i].text or new[i]),
					color = new[i].color or 0xFFF
				})
			else
				local newhud = table.copy(HUD_DEFINITIONS[i])

				newhud.offset.y = -(idx-1)*HUD_LINE_HEIGHT
				newhud.text = new[i].text or new[i]
				newhud.color = new[i].color or 0xFFF
				hud:add(player, hname, newhud)
			end
		elseif phud then
			hud:change(player, hname, {
				text = ""
			})
		end
	end
end

local function update_kill_list_hud(player)
	for i=1, HUD_LINES, 1 do
		update_hud_line(player, i, kill_list[i])
	end
end

local globalstep_timer = 0
local function add_kill(x, y, z)
	table.insert(kill_list, 1, {x, y, z})

	if #kill_list > HUD_LINES then
		table.remove(kill_list)
	end

	for _, p in pairs(minetest.get_connected_players()) do
		update_kill_list_hud(p)
	end

	globalstep_timer = 0
end

minetest.register_globalstep(function(dtime)
	globalstep_timer = globalstep_timer + dtime

	if globalstep_timer >= KILLSTAT_REMOVAL_TIME then
		globalstep_timer = 0

		table.remove(kill_list)

		for _, p in pairs(minetest.get_connected_players()) do
			update_kill_list_hud(p)
		end
	end
end)

call.register_on_new_match(function()
	kill_list = {}
	hud:clear_all()
end)

minetest.register_on_joinplayer(function(player)
	update_kill_list_hud(player)
end)

function cs_kh.add(killer, victim, weapon_image, comment)
	if type(killer) == "userdata" then
		killer2 = killer:get_player_name()
	end
	if type(victim) == "userdata" then
		victim2 = victim:get_player_name()
	end
	
	local function cs_kh.tmp_return_killer()
		if type(killer) == "string" then
			return killer
		elseif killer2 then
			return killer2
		end
	end
	local function cs_kh.tmp_return_victim()
		if type(victim) == "string" then
			return victim
		elseif victim2 then
			return victim2
		end
	end
	
	
	local k_team = csgo.pot[cs_kh.tmp_return_killer()]
	local v_team = csgo.pot[cs_kh.tmp_return_victim()]
	if not k_team then
		core.debug("red", "A error have been found while making new line... Ignoring....", "CsKillHistory")
		return
	end
	if not v_team then
		core.debug("red", "A error have been found while making new line... Ignoring....", "CsKillHistory")
		return
	end
	local kt_color = csgo.team[k_team].colour_code
	local vt_color = csgo.team[v_team].colour_code

	if type(discord) == "table" then
		discord.send(killer.." from "..k_team.." killed "..victim.." of "..v_team)
	end

	add_kill(
		{text = killer, color = kt_color or 0xFFF},
		weapon_image or "cs_files_hand.png",
		{text = victim .. (comment or ""), color = vt_color or 0xFFF}
	)
end
