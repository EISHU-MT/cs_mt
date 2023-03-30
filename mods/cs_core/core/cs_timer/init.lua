--
-- Timer For CS:GO Like was made by -EISHU-
-- v0.1 (First Release)
--

ctimer = {} -- CS_TIMER must be called but this i want hehe
ctimer.inv_time = 20 
mapeditor = clua.get_bool("map_edit", clua.get_table_value("central_csgo"), true)
temporal0x3281 = nil
local modpathh = core.get_modpath(minetest.get_current_modname())
dofile(modpathh.."/cs_timer/timer.conf")
dofile(modpathh.."/cs_timer/inv_timer_hud.lua")

minetest.register_on_joinplayer(function(player)
timehud = player:hud_add({
  hud_elem_type = "text",
  name = "hud_timer",
  scale = {x = 1.5, y = 1.5},
  position = {x = 0.485, y = -0.02},
  offset = {x = 30, y = 100},
  size = {x = 2},
  alignment = {x = 0, y = -1},
  text = "***D:HH:MM:SS***",
  number = 0xCECECE,
})
end)

function ctimer.on_end_type(type)
  if type == "c4" then
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
  answer = tostring(days)..':'..hours..':'..minutes..':'..seconds
  return answer
end

function ctimer.reset()
run = true
local time = default_timer
-- Undeclare values...
ctimer.commence = nil -- Line 49, function that need to be nil every round that commence, later its declared again SOLVED: Number multiplier
local temporal0x3281 = nil -- Clock colors
end

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
	time = time - DEFAULT_TIME -- Reverse action
	--print(time)
    if time == 0 then
        run = false
        --annouce.winner("No winner", "Timed out has reached") -- Whatever, this will be dont more available.
        --core.after(2, cs_match.finished_match)
       
        if not to_end then
        	number = {}
          if csgo.team.counter.count > csgo.team.terrorist.count then
          	number.r = clua.aif("Select random", {"the terrorist team is so tiny!", "timed out have been reached", "too low players in the game!"})
          	number.n = tonumber(1)
          elseif csgo.team.terrorist.count > csgo.team.counter.count then
          	number.r = clua.aif("Select random", {"the counter team is so tiny!", "timed out", "too low players!"})
          	number.n = tonumber(2)
          elseif csgo.team.terrorist.count == csgo.team.counter.count then
          	number.r = "By algotrithm this team have win!"
          	number.n = math.random(2)
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
        end
        if number.n == 2 then
          annouce.winner("counter", number.r)
          core.after(0.6, cs_match.finished_match, "counter")
          if c4.get_status() then
            c4.remove_bomb2()
          end
        end
        if number.n == 1 then
          annouce.winner("terrorist", number.r)
          core.after(0.6, cs_match.finished_match, "terrorist")

          if c4.get_status() then
            c4.remove_bomb2()
          end
        end
	number = {}
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
        player:hud_change(timehud, "text", timerare)
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


minetest.register_chatcommand("cs_timer_set", {
    privs = {core = true},
    func = function(name, param)
    	
    	time = param
        
    end,
})






















