local state = require "src.game_states.main.init"

updates = {
   input = true,
   player = false,
   entities = false
}

local keys = {
   w = "up",
   a = "left",
   s = "down",
   d = "right",

   escape = "pause_menu"
}

local bindings = {
   up = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y - 1][x].properties.walkable then
	 player:goUp()
	 
	 updates.input = false
	 updates.player = true
      end
   end,
   
   down = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y + 1][x].properties.walkable then
	 player:goDown()
	 
	 updates.input = false
	 updates.player = true
      end
   end,
   
   right = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y][x + 1].properties.walkable then
	 player:goRight()
	 
	 updates.input = false
	 updates.player = true
      end
   end,

   left = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y][x - 1].properties.walkable then
	 player:goLeft()

	 updates.input = false
	 updates.player = true
      end
   end,

   pause_menu = function (game_state)
      game_state.current = game_state.menu
   end
}

return {
   keys = keys,
   bindings = bindings
}
