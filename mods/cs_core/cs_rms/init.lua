-- Random Messages by EISHU la
randomMSG = {
"Shooting at enemy does more damage than ignoring them",
"With great power comes great responsibility",
"Good players don't hack",
"Dying from blocks is a bit sus, you know...",
"Defusing a bomb makes you team win!",
"Flying is not allowed!",
"Hacking is not allowed",
"Read the rules!",
"Planting the bomb is good for the terrorists but for counters is terrible...",
"Hiding in the shadows is better then getting shot by enimies",
"Remember to don't shoot at your teammates!",
"Our discord server is at: https://discord.gg/EWRYqfKXP8",
"Swearing is not allowed here",
"Trolling your teammates is strictly not allowed here",
"Camping is better than running around in open spaces",
"To get the most money just shoot at the enemy with best bounty",
"To do math here just say in chat \"CLUA math 4 + 4\" and then it will say 8.",
"Having nothing in hand increases speed and jump",
"To display you hotbar toggle it with: /helper_hud",
"Remember if you are afk, the game kicks you",
"Only one player can have the bomb and they must be a terrorist",
"When finished a match, remember to buy things befores time runs out!",
"To contribute maps, Get involved here!: https://github.com/EISHU-MT/cs_maps",
"This game is in Dev State, expect bugs and report using: /report!",
"This game is inspired by CS:GO Game",
"Team chat uses this command: /t <message>",
"To defuse the bomb hold the punch/dig key and wait the required amoun of time",
"To report any bug or crash, use the command: /report <bug> <description>",
"To report an player that is breaking the rules, use command: /report <name> <description>",
"To check on a player stats, use /r <player> or using /rank",
"Radio is available!. Use it for telling your position to your teammates, by using /radio <number of section *Optional!*>",
"Radio has GUI for newcomers",
"Global shop is added! Visit it with /gs to buy extra things",
"To buy costumes just search in /gs",
"Apples now can be used! Buy some with /gs",
"Remember things in /gs are not free!, /gs uses score as money.",
"Buying 'Unavailable!' adds something special to your inventory... Go discover it!",
"Score is same as money, when getting more, your moar rich, Dont waste all!",
"Remember some items in G.S. menu may be limited, like Christmas event, Hallowen event... All.",
"Dont be in front of the sniper! Or he will kill you!",
"Every good player, like camping/sniping player, has a bounty, every kill adds to their bounty, it can be 100, 200, 300 and more!",
"When a terrorist dies with the bomb there is a waypoint to the drop location",
"If you pick up the bomb and are not counter-terrorist, that is cheating",
"The bots may be dumb, but they have a good aim",
"Whats the best sniper: m200 or AWP?",
"This game is very very unstable, so report any crash."
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