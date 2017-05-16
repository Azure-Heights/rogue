local sti = require "src.sti"

local map = sti("assets/maps/simple_lava.lua")

local layer = map:addCustomLayer("floor")

layer.entities = { }
layer.draw_order = { }

-- Sort function for drawing order
local function sortY(a, b)
   return a.py < b.py
end

layer.reorder_draw = function (self)
   table.sort(self.draw_order, sortY)
end

layer.draw = function (self)
   self:reorder_draw()
   
   for _, entity in ipairs(self.draw_order) do
      entity:draw()
   end
end

-- Find spawn point
for k, object in pairs(map.objects) do
   if object.name == "player" then
      map.p_spawn = object
   elseif object.name == "spawn" then
      map.e_spawn = object
   end
end

return map
