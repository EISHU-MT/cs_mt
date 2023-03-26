-- CLua Addon
-- © 2023-2050 EISHU AM/EU/AS

-- Please read readme.md for more information

--http = nil
local url = clua.get_string("clua_relay", clua.get_table_value("clua"))
proto = {
	none = {[1] = "", [2] = ""},
	--Types
	bold = {[1] = "**", [2] = "**"},
	italic = {[1] = "*", [2] = "*"},
	bold_italic = {[1] = "***", [2] = "***"},
	--Underlines
	ubold = {[1] = "__**", [2] = "**__"},
	uitalic = {[1] = "__*", [2] = "*__"},
	ubold_italic = {[1] = "__***", [2] = "***__"},
	--Strikes
	sbold = {[1] = "~~**", [2] = "**~~"},
	sitalic = {[1] = "~~*", [2] = "*~~"},
	sbold_italic = {[1] = "~~***", [2] = "***~~"},
}

if not httpo then
    core.debug("red", "Cannot find HTTP/S api, Are clua_discord in secure mods or not", CLUA_AP)
    return
end


if not url then
    core.debug("red", "Clua TO->Channel url is missing. set in clua.cfg OR clua.conf the url, see in readme.txt", CLUA_AP)
    return
end

function clua.send_unit(data)
    local json = minetest.write_json(data)
    http.fetch({
        url = url,
        method = "POST",
        extra_headers = {"Content-Type: application/json"},
        data = json
    }, function(_,_,_,data)
        -- doin nothin
        --print(dump(data))
    end)
end

function clua.send_dtext(txt, dtype)
if txt then
	if dtype == "red" then
		colorr = 15548997
	elseif dtype == "green" then
		colorr = 5763719
	elseif dtype == nil or dtype ~= "green" or dtype ~= "red" then
		colorr = 16777215
	end
	local data = {
        content = nil,
        embeds = {{
            description = txt,
            color = colorr
        }}
    }
    clua.send_unit(data)
end
end

function clua.send_text(txt, dt, ty)
	if ty == nil or ty == " " or ty == "" then
		tyy = "no_type"
	elseif ty ~= nil or ty ~= " " or ty ~= "" then
		tyy = ty
	end
	if not dt or dt == nil or dt == false then
		ttx = "none"
	elseif dt and type(proto[dt]) == "table" then
		if dt == true then
			ttx = "none"
		else
			ttx = dt
		end
	end
	if txt then
		clua.send_unit({
			content = "["..os.date().." CO=PY|TYPE:"..tyy.."] " .. proto[ttx][1] .. txt .. proto[ttx][2]
		})
	end
end


