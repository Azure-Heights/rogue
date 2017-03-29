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

   -- Load map
   map = sti("assets/maps/simple_lava.lua")

   -- Add layer for displaying sprites
   local layer = map:addCustomLayer("sprites")
   layer.entities = { }

   layer.draw = function (self)
      player:draw(player.x, player.y)
   end

   -- Find spawn point
   local spawn
   for k, object in pairs(map.objects) do
      if object.name == "player" then
	 spawn = object
	 break
      end
   end

   -- Spawn player with position adjustments
   player = Entity.newInstance{name = "player", x = spawn.x + 16, y = spawn.y + 16}
end

function love.update(dt)
   -- Update map animations
   map:update(dt)

   -- Break here if player update flag is not set
   if updates.player == false then return end

   -- Update update flags
   if player:update(dt) then
      updates.player = false
      updates.input = true
   end
end

function love.draw()
   -- Calculate offset to keep window centered on player
   local tx = math.floor(player.x - width / 2)
   local ty = math.floor(player.y - height / 2)
   
   love.graphics.translate(-tx, -ty)

   -- Draw map
   map:draw()
end

function love.keypressed(k)
   if updates.input then
      local action = game_states.main.input.keys[k]

      if action then
	 game_states.main.input.bindings[action]()
      end
   end
end
