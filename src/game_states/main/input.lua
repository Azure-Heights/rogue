local game_state = require "src.game_state"
local state = require "src.game_states.main.state"

local bindings = {
   up = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)

      local properties = state.map.layers.pathing.data[y - 1][x].properties

      if properties[player.movement] then
	 state:moveEntity(player, "up")
	 state.updates.progress()
      end
   end,
   
   down = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)
      
      local properties = state.map.layers.pathing.data[y + 1][x].properties

      if properties[player.movement] then
	 state:moveEntity(player, "down")
	 state.updates.progress()
      end
   end,
   
   right = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)
      
      local properties = state.map.layers.pathing.data[y][x + 1].properties

      if properties[player.movement] then
	 state:moveEntity(player, "right")
	 state.updates.progress()
      end
   end,

   left = function ()
      -- Check if tile is walkable
      local x, y = state.map:convertPixelToTile(player.px, player.py)
      
      local properties = state.map.layers.pathing.data[y][x - 1].properties

      if properties[player.movement] then
	 state:moveEntity(player, "left")
	 state.updates.progress()
      end
   end,

   pass = function ()
      state.updates.current = state.updates.enemies
   end,

   pause_menu = function ()
      game_state.current = game_state.menu
   end
}

return {
   keys = keys,
   bindings = bindings
}
