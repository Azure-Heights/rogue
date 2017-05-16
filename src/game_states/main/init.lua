local state = require "src.game_states.main.state"
local utils = require "src.utils"

state.updates = require "src.game_states.main.updates"
state.input = require "src.game_states.main.input"

state.map = require "src.game_states.main.map"

state.map.width = state.map.layers.base.width
state.map.height = state.map.layers.base.height

state.floor = state.map.layers.floor
state.floor.data = state.map.layers.pathing.data

state.progress_now = false

state.animations = { }

state.entities = { }
for i = 1, state.map.height do
   state.entities[i] = { }
   for j = 1, state.map.width do
      state.entities[i][j] = nil
   end
end

function state.update(self, dt)
   -- Update map animations
   self.map:update(dt)

   -- Update entities
   player:update(dt)
   for _, entity in pairs(self.floor.entities) do
      entity:update(dt)
   end

   -- Check if animations have been completed
   if self:updateAnimations() then
      if self.updates.current.update then
	 self.updates.current:update(dt)

	 -- If there are no animations added, progress
	 if #self.animations == 0 then
	    self.updates.progress()
	 end
      end
   end
end

function state.draw(self, width, height)
   -- Calculate offset to keep window centered on player
   local tx = math.floor(player.px - width / 2)
   local ty = math.floor(player.py - height / 2)
   
   love.graphics.translate(-tx, -ty)

   self.map:draw()
end

function state.moveEntity(self, entity, dir)
   self.entities[entity.y][entity.x] = nil

   entity:move(dir)

   self.entities[entity.y][entity.x] = entity
end

function state.addAnimation(self, animation)
   table.insert(self.animations, animation)
end

function state.updateAnimations(self)
   return utils.updateCoroutines(self.animations)
end

function state.inputHandler(self, k)
   local action = self.updates.current.keys[k]
   
   if action then self.input.bindings[action]() end
end

-- Initialize player
player = Entity.newInstance{name = "player",
			    x = state.map.p_spawn.x + 32,
			    y = state.map.p_spawn.y + 32}
state.entities[player.y][player.x] = player

-- Initialize enemy
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
