require "src.lovedebug"

require "src.utils"

Sprite = require "src.animated_sprite"
Entity = require "src.entity"

local game_state = { }

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

math.randomseed(os.time())

function love.load()
   -- Load assets
   Sprite.load("assets/sprites/eyeball.lua")
   Sprite.load("assets/sprites/player.lua")

   Entity.load("assets/entities/eyeball.lua")
   Entity.load("assets/entities/player.lua")

   game_state = require "src.game_states.states"
end

function love.update(dt)
   if game_state.current.update then
      game_state.current:update(dt)
   end
end

function love.draw()
   if game_state.current.draw then
      game_state.current:draw(width, height)
   end
end

function love.keypressed(k)
   if game_state.current.inputHandler then
      game_state.current:inputHandler(k)
   end
end
