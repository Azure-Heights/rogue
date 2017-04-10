local updates = { }

updates.input = {
   keys = {
      w = "up",
      a = "left",
      s = "down",
      d = "right",

      space = "pass",
      escape = "pause_menu"
   }
}

updates.player = {
   keys = { },
   
   update = function (self, dt, state)
      if player:update(dt) then
	 state.floor:turnTick()
	 state.floor:turn(state)
	 
	 updates.current = updates.enemies
      end
   end
}

updates.enemies = {
   keys = { },
   
   update = function (self, dt, state)
      local finished = true
      
      for _, entity in ipairs(state.floor.entities) do
	 local check = entity:update(dt)
	 
	 if check then
	    if entity:turn(state) then finished = false end
	 elseif not check and finished then
	    finished = false
	 end
      end

      if finished then updates.current = updates.input end
   end
}

updates.current = updates.input

return updates
