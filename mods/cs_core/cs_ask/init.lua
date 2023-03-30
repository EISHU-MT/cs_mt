cs_ask = {
	datas = {},
	switches = {
		--activate_switcher = {value = true},
		frosen = {value = false, active = true}, 
		
	},
}

function csgo.switch(name, value)
	if name and value and (not type(name) == "boolean") then
		if cs_ask.switches[tostring(name)].active then
			cs_ask.switches[tostring(name)].value = value
		end
	end
end
function csgo.ask(name)
	if name then
		if cs_ask.switches[tostring(name)].active == true then
			return cs_ask.switches[tostring(name)].value
		end
	end
end