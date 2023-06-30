restart = false
restartm = "This server is being restarted from operator request"
-- Restart on finish all matchs
core.register_chatcommand("queue_restart", {
	description = "Restart server on finish all matchs",
	params = "<message>",
	func = function(name, param)
        --Param is optional
        restart = true
        if param and param ~= "" then
            restartm = param
        else
            restartm = "This server is being restarted from operator request"
        end
    end,
	privs = {server=true, core=true}
})
call.register_on_new_matches(function()
    if restart then
        core.request_shutdown(restartm)
    end
end)

core.register_chatcommand("report", {
	description = "Report any bug or player",
	params = "<bug or player> <description>",
	func = function(name, param)
		local tabled = param:split(" ")
		local storage = csgo.request_modstorage()
		local storage_of_reports = storage:get_string("reports")
		if tabled and tabled[1] then
			if tabled[2] then
				if storage_of_reports ~= "" or storage_of_reports ~= nil then
					local reports = core.deserialize(storage_of_reports)
					if type(reports) == "table" then
						table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					else
						reports = {}
						table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					end
					storage:set_string("reports", core.serialize(reports))
					core.chat_send_player(name, "-!- Report have been sent.")
				else
					local reports = {}
					table.insert(reports, "Player "..name.." reported: (Name: "..tabled[1]..", Desc: "..tabled[2]..")")
					storage:set_string("reports", core.serialize(reports))
					core.chat_send_player(name, "-!- Report have been sent.")
				end
			else
				core.chat_send_player(name, "-!- Description is not provided!")
			end
		else
			core.chat_send_player(name, "-!- Name is not provided!")
		end
	end,
})

core.register_chatcommand("show_reports", {
	description = "Show all reports",
	params = "<nothing>",
	privs = {kick=true},
	func = function(name, param)
		local storage = csgo.request_modstorage()
		local storage_of_reports = storage:get_string("reports")
		if storage_of_reports ~= "" or storage_of_reports ~= nil then
			local data = core.deserialize(storage_of_reports) or {"Empty."}
			local concat = table.concat(data, "\n")
			core.chat_send_player(name, concat)
			storage:set_string("reports", nil)
		else
			core.chat_send_player(name, "-!- Database is empty.")
		end
	end,
})













