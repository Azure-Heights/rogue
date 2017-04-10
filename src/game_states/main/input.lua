local state = require "src.game_states.main.init"

local bindings = {
   up = function (game_state, state)
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)

      local properties = state.map.layers.pathing.data[y - 1][x].properties

      if properties[player.movement] then
	 state:moveEntity(player, "up")
	 state.updates.current = state.updates.player
      end
   end,
   
   down = function (game_state, state)
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)
      
      local properties = state.map.layers.pathing.data[y + 1][x].properties

      if properties[player.movement] then
	 state:moveEntity(player, "down")
	 state.updates.current = state.updates.player
      end
   end,
   
   right = function (game_state, state)
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)
      
      local properties = state.map.layers.pathing.data[y][x + 1].properties

      if properties[player.movement] then
	 state:moveEntity(player, "right")
	 state.updates.current = state.updates.player
      end
   end,

   left = function (game_state, state)
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)
      
      local properties =  state.map.layers.pathing.data[y][x - 1].properties

      if properties[player.movement] then
	 state:moveEntity(player, "left")
	 state.updates.current = state.updates.player
      end
   end,

   pass = function ()
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
