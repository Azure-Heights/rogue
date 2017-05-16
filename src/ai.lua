local ai = { }
local state = require "src.game_states.main.state"

local opposite_dirs = {
   up = "down",
   down = "up",
   right = "left",
   left = "right"
}

ai.getDirections = function (entity, px, py)
   local dirs = { }

   local x, y = state.map:convertPixelToTile(px, py)
   
   if state.floor.data[y - 1][x].properties[entity.movement]
   and state.entities[y - 1][x] == nil then
      table.insert(dirs, "up")
   end

   if state.floor.data[y + 1][x].properties[entity.movement]
   and state.entities[y + 1][x] == nil then
      table.insert(dirs, "down")
   end
   
   if state.floor.data[y][x + 1].properties[entity.movement]
   and state.entities[y][x + 1] == nil then
      table.insert(dirs, "right")
   end

   if state.floor.data[y][x - 1].properties[entity.movement]
   and state.entities[y][x - 1] == nil then
      table.insert(dirs, "left")
   end

   return dirs
end

ai.getDirectionTo = function (entity, x, y)
   local x_diff = entity.x - x
   local y_diff = entity.y - y
   
   if math.abs(x_diff) > math.abs(y_diff) then
      if x_diff < 0 then
	 return "right"
      else
	 return "left"
      end
   else
      if y_diff < 0 then
	 return "down"
      else
	 return "up"
      end
   end
end

ai.getReverse = function (dir)
   return opposite_dirs[dir]
end

ai.getCoordsInDir = function (x, y, dir)
   if dir == "up" then
      return x, y - 1
   elseif dir == "down" then
      return x, y + 1
   elseif dir == "right" then
      return x + 1, y
   elseif dir == "left" then
      return x - 1, y
   end
end

ai.getDistance = function (entity, x, y)
   local x = math.abs(entity.x - x)
   local y = math.abs(entity.y - y)
   
   return x, y, math.sqrt(x^2 + y^2)
end

return ai
