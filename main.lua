require "src.lovedebug"

local sti = require "src.sti"

local Sprite = require "src.animated_sprite"
local Entity = require "src.entity"

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
   local update = game_state.current.update
   if update then update(dt) end
end

function love.draw()
   local draw = game_state.current.draw

   if draw then draw(width, height) end
end

function love.keypressed(k)
   local handler = game_state.current.inputHandler
   if handler then handler(game_state, k) end
end
