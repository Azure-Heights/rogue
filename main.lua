local sti = require "src.sti"

local Sprite = require "src.animated_sprite"
local Entity = require "src.entity"

local game_states = require "src.game_states.states"

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

function love.load()
   -- Load assets
   Sprite.load("assets/sprites/player.lua")
   Entity.load("assets/entities/player.lua")

   spawn_x = game_states.main.map.spawn.x
   spawn_y = game_states.main.map.spawn.y
   
   player = Entity.newInstance{name = "player", x = spawn_x + 16, y = spawn_y + 16}
end

function love.update(dt)
   game_states.main.update(dt)
end

function love.draw()
   game_states.main.draw(width, height)
end

function love.keypressed(k)
   if updates.input then
      local action = game_states.main.input.keys[k]

      if action then
	 game_states.main.input.bindings[action]()
      end
   end
end
