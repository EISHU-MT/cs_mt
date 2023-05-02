--
-- Timer For CS:GO Like was made by -EISHU-
-- v0.1 (First Release)
--
do
	ctimer = {} -- CS_TIMER must be called but this i want hehe
	ctimer.inv_time = 20 
	timed = 0
	time = 0
	to_end = nil
	color = nil
	commenced_time = nil
	opts = {}
	--core.after(5, DESTROY_THE_ENTIRE_UNIVERSE)
	mapeditor = minetest.settings:get_bool("cs_map.mapmaking", false)
end

local modpathh = core.get_modpath(minetest.get_current_modname())
dofile(modpathh.."/cs_timer/timer.conf")
dofile(modpathh.."/cs_timer/inv_timer_hud.lua")


function ctimer.on_end_type(typel)
  if typel == "c4" then
    to_end = "explode"
  end
end

function ctimer.disp_time(time) -- 0.0
  local days = math.floor(time/86400)
  local remaining = time % 86400
  local hours = math.floor(remaining/3600)
  remaining = remaining % 3600
  local minutes = math.floor(remaining/60)
  remaining = remaining % 60
  local seconds = remaining
  if (hours < 10) then
    hours = "0" .. tostring(hours)
  end
  if (minutes < 10) then
    minutes = "0" .. tostring(minutes)
  end
  if (seconds < 10) then
    seconds = "0" .. tostring(seconds)
  end
  answer = tostring(minutes..':'..seconds)
  return answer
end

function ctimer.reset()
time = default_timer
color = 0xFFFFFF
end

function ctimer.pause(m)
	time = 20
	core.chat_send_all("Buy armor & rifles or pistols for the fight!")
end





local function reg_glb(dtime)
	timed = timed + dtime
	if type(time) ~= "number" then
		ctimer.reset()
	end
	if timed >= 1 then
		if cs_match.commenced_match == false then
			
			time = time - 1
			if time < 10 then
				color = 0xFF5454
			end
			if time == 0 then
				cs_buying.disable_shopping()
				core.after(0.2, function()
					ctimer.reset()
				end)
				csgo.on_movement()
				remove_hsa()
				
				if type(temp999) == "function" then
					temp999()
				end
				
				ccore.teams.terrorist.players = {}
				ccore.teams.counter.players = {}
				
				function finishedmatch() return true end
				
				cs_match.commenced_match = true
				
				color = 0xFFFFFF
			end
		end
		if cs_match.commenced_match ~= false then
			--print("exec: if cs_match*")
			if time then
				--print("exec: success")
				time = time - 1
				if time < 60 then
					color = 0xFF5454
				end
				if time == 0 then
				--error()
				--core.chat_send_all("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
					if to_end then
						c4.bomb_now()
						local user = c4.get_planter()
						annouce.winner("terrorist", "Congrats to "..user.." for planting the c4!")
						core.after(0.6, cs_match.finished_match, "terrorist")
						c4.remove_bomb()
						c4.remove_bomb2()
						to_end = nil
					else
						if csgo.team.counter.count > csgo.team.terrorist.count then
							opts.r = Randomise("Select random", {"the terrorist team is so tiny!", "timed out have been reached", "too low players in the game!"})
							opts.n = tonumber(1)
						elseif csgo.team.terrorist.count > csgo.team.counter.count then
							opts.r = Randomise("Select random", {"the counter team is so tiny!", "timed out", "too low players!"})
							opts.n = tonumber(2)
						elseif csgo.team.terrorist.count == csgo.team.counter.count then
							opts.r = "By algotrithm this team have win!"
							opts.n = math.random(2)
						end
						
						if opts then
							if opts.n == 1 then
								annouce.winner("terrorist", opts.r)
								core.after(0.2, cs_match.finished_match, "terrorist")
							elseif opts.n == 2 then
								annouce.winner("terrorist", opts.r)
								core.after(0.2, cs_match.finished_match, "terrorist")
							end
						end
					end
				end
			else
				print(time)
				time = default_timer
				print(default_timer)
			end
		end
		for _, player in pairs(core.get_connected_players()) do
			if time ~= -1 and (timehud) and time and color then
				player:hud_change(timehud[player:get_player_name()], "text", ctimer.disp_time(time)) -- Time
				player:hud_change(timehud[player:get_player_name()], "number", color)  -- Color
			end
		end
	timed = 0
	end
end

minetest.register_globalstep(reg_glb)



















--[[
function ctimer.set_timer(timer) -- timer can be optional
if timer then
default_timer = timer
else
default_timer = de_timer
end
temporal0x3281 = nil
run = true
time = default_timer
--minetest.register_globalstep(function(dtime) -- Has too much errors
function ctimer.commence()
if mapeditor ~= true then
	time = time - 1 -- Reverse action
	--print(time)
    if time == 0 then
        run = false
        --annouce.winner("No winner", "Timed out has reached") -- Whatever, this will be dont more available.
        --core.after(2, cs_match.finished_match)
       
        if not to_end then
        	numberrr = {}
          if csgo.team.counter.count > csgo.team.terrorist.count then
          	numberrr.r = Randomise("Select random", {"the terrorist team is so tiny!", "timed out have been reached", "too low players in the game!"})
          	numberrr.n = tonumber(1)
          elseif csgo.team.terrorist.count > csgo.team.counter.count then
          	numberrr.r = Randomise("Select random", {"the counter team is so tiny!", "timed out", "too low players!"})
          	numberrr.n = tonumber(2)
          elseif csgo.team.terrorist.count == csgo.team.counter.count then
          	numberrr.r = "By algotrithm this team have win!"
          	numberrr.n = math.random(2)
          end
          
          
          if not numberrr then
          	numberrr = {}
          	numberrr.r = Randomise("Select random", {"They had win", "timed out", "a", "By algotrithm this team have win!\n--Failure of lua engine!"})
          	numberrr.n = math.random(2)
          end
          
          --number = math.random(2)
        elseif to_end == "explode" then
          c4.bomb_now()
          user = c4.get_planter()
          annouce.winner("terrorist", "Congrats to "..user.." for planting the c4!")
          core.after(0.6, cs_match.finished_match, "terrorist")
          c4.remove_bomb()
          c4.remove_bomb2()
          to_end = nil
          return
        end
        if numberrr.n == 2 then
          annouce.winner("counter", numberrr.r)
          core.after(0.6, cs_match.finished_match, "counter")
          if c4.get_status() then
            c4.remove_bomb2()
          end
        end
        if numberrr.n == 1 then
          annouce.winner("terrorist", numberrr.r)
          core.after(0.6, cs_match.finished_match, "terrorist")

          if c4.get_status() then
            c4.remove_bomb2()
          end
        end
	numberrr = {}
        --print("debug9")
    end
	if time == 60 then
		coloring = 0xFF9D86
		temporal0x3281 = true
	elseif (not temporal0x3281) then
		coloring = 0xCECECE
	end
    if run ~= false then 
	--time_next = math.floor(time)
	
	timerare = ctimer.disp_time(time)
	
  for _, player in pairs(core.get_connected_players()) do
	
    if player then
  
      
        
      
      if time ~= -1 and (timehud) then
        player:hud_change(timehud[player:get_player_name()], "text", timerare)
      end
  
      
  
        
      
  
      
        --hud:remove(player, "timerrrr") -- no.
    end
    
    end
	
	
	
    end
if type(ctimer.commence) == "function" then
core.after(1, ctimer.commence)
--time = time - DEFAULT_TIME -- Reverse action
--core.after(5, function() minetest.chat_send_all(minetest.colorize(coloring, timerare))  end)

end
end
end
if type(ctimer.commence) == "function" then
--  time = time - DEFAULT_TIME -- Reverse action
core.after(1, ctimer.commence)
end



end
--]]


minetest.register_chatcommand("cs_timer_set", {
    privs = {core = true},
    func = function(name, param)
    	
    	time = param
        
    end,
})

function aefd()
	print("a")
	
	cs_core.cooldown(0.1)
	aefd()
end

minetest.register_chatcommand("no", {
    func = function(name, param)
    	
    	aefd()
        
    end,
})






















