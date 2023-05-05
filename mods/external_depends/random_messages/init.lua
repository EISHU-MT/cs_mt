-- Random Messages by EISHU la
randomMSG = {
"Shooting at enemy does more damage than ignoring them",
"With great power comes great responsibility",
"Playing goodly is not hacking",
"Dying from blocks is a bit sus, you know...",
"Defusing a bomb makes you team win!",
"Flying is not allowed!",
"Hacking is not allowed",
"Reading the rules is more good than ignoring it...",
"Planting the bomb is good for the terrorists but for counters is terrible...",
"Hiding in the shadows is intelligent than showing your self at enemy...",
"Remember to dont shoot at your teammates!",
"Our discord server is at: ",
"Swearing is not allowed here",
"Trolling your teammates is strictly not allowed here",
"Camping at the roof of a house is more good than being in the bright to be seen for enemis",
"To get more money just shoot at the enemy with best bounty",
"To do math here just say in chat \"CLUA math 4 + 4\" and then it will say 8.",
"Hading nothing in hand increases speed and jump",
"To had the hotbar and not items hud just do: /helper_hud",
"Remember if you afk, the game kicks you out",
"Only One player can had the bomb and is need to be terrorist too",
"When finished a match, remember to buy things befores it times out!",
"To contribute maps, Get involved here!: github.com/EISHU92/cs_maps",
"This game are in dev state, expect bugs and report it to help us!",
"This game is inspired by CS:GO Game",
"To chat only with ur teammates use this command: /m",
"To defuse a bomb maintain pressed the punch/dig button/touchpad and wait the seconds that require",
"To report an bug or crash, use the command: /report <bug> <description>",
"To report an player that is breaking the rules, use command: /report <name> <description>"
}
time_to_say = 90
rmtime = 0
last_msg = " "
core.register_globalstep(function(dtime)
	rmtime = rmtime + dtime
	if rmtime > time_to_say then
		local msg = Randomise("Select random", randomMSG)
		if randomMSG and last_msg ~= msg then
			core.chat_send_all(core.colorize("#1BE22A", msg))
			if discord and no == false then
				discord.send(msg)
			end
			last_msg = msg
		end
		rmtime = 0
	end
end)