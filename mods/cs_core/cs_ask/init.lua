cs_ask = {
	datas = {},
	switches = {
		--activate_switcher = {value = true},
		frosen = {value = false, active = true}, 
		
	},
}

function csgo.switch(name, value)
	if name and value then
		if cs_ask.switches[name].active == true then
			cs_ask.switches[name] = value
		end
	end
end
function csgo.ask(name)
	if name then
		if cs_ask.switches[name].active == true then
			return cs_ask.switches[name].value
		end
	end
end