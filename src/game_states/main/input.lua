local game_state = require "src.game_state"
local state = require "src.game_states.main.state"

local utils = require "src.utils"

local bindings = {
   up = function ()
      -- Check if tile is walkable
      local properties = state.map.layers.pathing.data[player.y - 1][player.x].properties

      if state.entities[player.y - 1][player.x] == nil then
	 if properties[player.movement] then
	    state:moveEntity(player, "up")
	    state.updates.progress()
	 end
      else
	 player:attack("up")
	 state.updates.progress()
      end
   end,
   
   down = function ()
      -- Check if tile is walkable
      local properties = state.map.layers.pathing.data[player.y + 1][player.x].properties

      if state.entities[player.y + 1][player.x] == nil then
	 if properties[player.movement] then
	    state:moveEntity(player, "down")
	    state.updates.progress()
	 end
      else
	 player:attack("down")
	 state.updates.progress()
      end
   end,
   
   right = function ()
      -- Check if tile is walkable
      local properties = state.map.layers.pathing.data[player.y][player.x + 1].properties

      if state.entities[player.y][player.x + 1] == nil then
	 if properties[player.movement] then
	    state:moveEntity(player, "right")
	    state.updates.progress()
	 end
      else
	 player:attack("right")
	 state.updates.progress()
      end
   end,

   left = function ()
      -- Check if tile is walkable
      local properties = state.map.layers.pathing.data[player.y][player.x - 1].properties

      if state.entities[player.y][player.x - 1] == nil then
	 if properties[player.movement] then
	    state:moveEntity(player, "left")
	    state.updates.progress()
	 end
      else
	 player:attack("left")
	 state.updates.progress()
      end
   end,

   pause_menu = function ()
      game_state.current = game_state.menu
   end
}

return {
   keys = keys,
   bindings = bindings
}
