local sti = require "src.sti"

local state = { }

-- Load map
state.map = sti("assets/maps/simple_lava.lua")

-- Add layer for displaying sprites
local layer = state.map:addCustomLayer("sprites")
layer.entities = { }

layer.draw = function (self)
   player:draw(player.x, player.y)
end

-- Find spawn point
for k, object in pairs(state.map.objects) do
   if object.name == "player" then
      state.map.spawn = object
      break
   end
end

function state.update(dt)
   -- Update map animations
   state.map:update(dt)

   -- Break here if player update flag is not set
   if updates.player == false then return end

   -- Update update flags
   if player:update(dt) then
      updates.player = false
      updates.input = true
   end
end

function state.draw(width, height)
   -- Calculate offset to keep window centered on player
   local tx = math.floor(player.x - width / 2)
   local ty = math.floor(player.y - height / 2)
   
   love.graphics.translate(-tx, -ty)

   -- Draw map
   state.map:draw()
end

return state
