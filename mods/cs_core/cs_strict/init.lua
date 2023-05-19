local storage = minetest.get_mod_storage("cs_strict")
local t = minetest.get_translator("cs_strict")
if not strict then
	core.log("warning", "Could not detect API for cs_strict, 'cs_strict_api', returning...")
	return
end
do
	local strs = storage:get_string("players")
	if strs == "" or strs == " " or strs == nil then
		local newtable = {
					__null = 0
				}
		local sr = core.serialize(newtable)
		storage:set_string("players", sr)
	end
end
log = core.log
css_queue = {}
css_timer = 0
function plus_to_player(player)
	local dsr = core.deserialize(storage:get_string("players"))
	if player then
		if dsr[player] == nil or dsr[player] == "" then
			dsr[player] = 0
		end
		dsr[player] = dsr[player] + 1
	end
	storage:set_string("players", core.serialize(dsr))
end
function get_player(player)
	local dsr = core.deserialize(storage:get_string("players"))
	return dsr[player] or 0
end
function reg_on_chat(name, msg)
	if strict then
		local bool = strict.find_word(msg)
		if bool == true then
			core.chat_send_player(name, core.colorize("#FF0000", t("Dont curse / no swearing!")))
			plus_to_player(name)
			local num = get_player(name)
			if num >= 3 and num < 5 then
				core.chat_send_all("### "..name.." left from cursing/swearing")
				core.disconnect_player(name, t("Broke the rule 2nd"))
				return true
			elseif num >= 5 then
				css_queue[name] = 2
			end
			return true
		end
	end
end
function reg_on_step(dtime) -- death on_step
	css_timer = css_timer + dtime
	if css_timer >= 1 then
		for name, value in pairs(css_queue) do
			print(value)
			if name and value and type(value) ~= "boolean" then
				if value ~= 0 then
					css_queue[name] = value - 1
				elseif value == 0 or value <= 0 then
					log("action", "Banned player from cursing / swearing, from queues")
					core.ban_player(name)
					css_queue[name] = nil
				end
			end
		end
	end
end

core.register_globalstep(reg_on_step)
core.register_on_chat_message(reg_on_chat)