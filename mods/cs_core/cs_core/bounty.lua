bounty = {}
bounty_modes = {
	[1] = 10,
	[2] = 20,
	[3] = 30,
	[4] = 40,
	[5] = 50,
	[6] = 60,
	[7] = 70,
	[8] = 80,
	[9] = 90,
	[10] = 100,
}

local function annouce(name, enemy, v)
	core.chat_send_all(core.colorize("#00DBDB", "[BOUNTY] "..name.." killed "..enemy.." and received ")..core.colorize("#009200", v)..core.colorize("#00DBDB", " points"))
end

local function annouce_free_bounty(name, v)
	core.chat_send_all(core.colorize("#00DBDB", "[BOUNTY] Player "..name.."'s bounty: ")..core.colorize("#009200", v)..core.colorize("#00DBDB", " points"))
end

local function on_kill(id, k_id, vtabled)
	local victim_name = Name(id)
	local killer_name = Name(k_id)
	local to_use = 0
	if bounty[victim_name] > 0 then
		if bounty[victim_name] > 10 then
			to_use = 10
		else
			to_use = bounty_modes[bounty[victim_name]]
		end
	end
	if to_use > 30 then
		annouce(killer_id, victim_name, to_use)
	end
	bounty[killer_name] = bounty[killer_name] + 1
	if (bounty[killer_name] + 1) > 3 then
		annouce_free_bounty(killer_name, 10 + bounty_modes[bounty[killer_name]])
	end
	score.add_score_to(killer_name, 10 + to_use, true)
end