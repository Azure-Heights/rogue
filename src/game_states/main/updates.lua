local state = require "src.game_states.main.state"

local updates = { }

updates.input = {
   name = "input",
   
   keys = {
      w = "up",
      a = "left",
      s = "down",
      d = "right",
      
      escape = "pause_menu"
   }
}

updates.enemies = {
   name = "enemies",
   
   keys = { },
   
   update = function (self, dt)
      for _, entity in ipairs(state.floor.entities) do
	 if entity.turn_tick >= 1 then entity:turn() end
      end
   end
}

updates.progress = function ()
   if updates.current == updates.input then
      for _, entity in ipairs(state.floor.entities) do
	 entity:turnTick()
      end

      updates.current = updates.enemies
   else
      updates.current = updates.input
   end
end

updates.current = updates.input

return updates
