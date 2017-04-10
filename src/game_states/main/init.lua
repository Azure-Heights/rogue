local Entity = require "src.entity"

local state = { }

state.updates = require "src.game_states.main.updates"

state.map = require "src.game_states.main.map"

state.map.width = state.map.layers.base.width
state.map.height = state.map.layers.base.height

state.floor = state.map.layers.floor
state.floor.data = state.map.layers.pathing.data

state.entities = { }
for i = 1, state.map.layers.base.height do
   state.entities[i] = { }
   for j = 1, state.map.layers.base.width do
      state.entities[i][j] = { }
   end
end

function state.update(dt)
   -- Update map animations
   state.map:update(dt)

   if state.updates.current.update then
      state.updates.current:update(dt, state)
   end
end

function state.draw(width, height)
   -- Calculate offset to keep window centered on player
   local tx = math.floor(player.px - width / 2)
   local ty = math.floor(player.py - height / 2)
   
   love.graphics.translate(-tx, -ty)

   state.map:draw()
end

function state.moveEntity(self, entity, dir)
   state.entities[entity.y][entity.x] = nil
   entity:move(dir)
   state.entities[entity.y][entity.x] = entity
end

function state.inputHandler(game_state, k)
   local action = state.updates.current.keys[k]
   
   if action then state.input.bindings[action](game_state, state) end
end

-- Initialize player
player = Entity.newInstance{name = "player",
			    x = state.map.p_spawn.x + 32,
			    y = state.map.p_spawn.y + 32}
state.entities[player.y][player.x] = player

local eyeball = Entity.newInstance{name = "eyeball",
				   x = state.map.e_spawn.x + 32,
				   y = state.map.e_spawn.y + 32}
table.insert(state.floor.entities, eyeball)
state.entities[eyeball.y][eyeball.x] = eyeball

-- Update draw order of sprites
state.floor.draw_order = { player }
for _, entity in ipairs(state.floor.entities) do
   table.insert(state.floor.draw_order, entity)
end

return state
