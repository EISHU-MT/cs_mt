-- This dont provide callbacks! This uses callbacks from other mods!!
local function on_bomb(name)
	score.add_score_to(name, 80, true)
end
local function on_join(player)
	local players = score.get_storedDA()
	if players[Name(player)] then return end
	score.raw_modifyTO(Name(player), 0)
end
core.register_on_joinplayer(on_join)