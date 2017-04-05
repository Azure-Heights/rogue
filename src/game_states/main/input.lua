local state = require "src.game_states.main.init"

local bindings = {
   up = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y - 1][x].properties.walkable then
	 player:goUp()
      end

      state.updates.current = state.updates.player
   end,
   
   down = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y + 1][x].properties.walkable then
	 player:goDown()
      end

      state.updates.current = state.updates.player
   end,
   
   right = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y][x + 1].properties.walkable then
	 player:goRight()
      end

      state.updates.current = state.updates.player
   end,

   left = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.x, player.y)
      
      if state.map.layers.pathing.data[y][x - 1].properties.walkable then
	 player:goLeft()
      end

      state.updates.current = state.updates.player
   end,

   pause_menu = function (game_state)
      game_state.current = game_state.menu
   end
}

return {
   keys = keys,
   bindings = bindings
}
