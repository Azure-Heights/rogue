local sti = require "src.sti"

local Sprite = require "src.animated_sprite"
local Entity = require "src.entity"

local game_state = require "src.game_states.states"

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

function love.load()
   -- Load assets
   Sprite.load("assets/sprites/player.lua")
   Entity.load("assets/entities/player.lua")

   spawn_x = game_state.main.map.spawn.x
   spawn_y = game_state.main.map.spawn.y
   
   player = Entity.newInstance{name = "player", x = spawn_x + 16, y = spawn_y + 16}
end

function love.update(dt)
   game_state.current.update(dt)
end

function love.draw()
   game_state.current.draw(width, height)
end

function love.keypressed(k)
   if updates.input then
      local action = game_state.current.input.keys[k]

      if action then
	 game_state.current.input.bindings[action](game_state)
      end
   end
end
