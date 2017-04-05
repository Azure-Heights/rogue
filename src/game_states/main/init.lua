local sti = require "src.sti"
local Entity = require "src.entity"

local state = { }
state.updates = require "src.game_states.main.updates"

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

player = Entity.newInstance{name = "player", x = state.map.spawn.x + 16, y = state.map.spawn.y + 16}

function state.update(dt)
   -- Update map animations
   state.map:update(dt)

   update = state.updates.current.update
   if update then update(dt) end
end

function state.draw(width, height)
   -- Calculate offset to keep window centered on player
   local tx = math.floor(player.x - width / 2)
   local ty = math.floor(player.y - height / 2)
   
   love.graphics.translate(-tx, -ty)

   -- Draw map
   state.map:draw()
end

function state.inputHandler(game_state, k)
   local action = state.updates.current.keys[k]
   
   if action then state.input.bindings[action](game_state) end
end

return state
