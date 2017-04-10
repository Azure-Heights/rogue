local Sprite = require "src.animated_sprite"

local entity_bank = { }

local function load(entity_def)
   -- Exit if no entity path given
   if entity_def == nil then return nil end

   -- Load entity path
   local def_file = loadfile(entity_def)

   if def_file == nil then
      print("Attempt to load invalid file: "..entity_def)
      return nil
   end

   -- Add entity to bank
   local entity = def_file()
   
   entity_bank[entity.name] = entity

   return entity_bank[entity.name]
end

local function newInstance(args)
   -- Create new instance from entity bank
   local sprite = Sprite.newInstance{
      name = entity_bank[args.name].sprite_name, rotation = args.rotation}
   local default = entity_bank[args.name]

   local x = args.x or 0
   local y = args.y or 0
   
   return {
      name = default.name,
      
      health = default.health or 100,
      max_health = default.health or 100,

      speed = default.speed or 1,
      turn_tick = 0,

      x = x / 32,
      y = y / 32,
      
      px = x,
      py = y,
      
      new_pos = { x = args.x or 0, y = args.y or 0 },

      movement = default.movement or "walking",
      to_move = { x = 0, y = 0 },

      sprite = sprite,

      turn = function (self, state)
	 if self.turn_tick >= 1 then
	    self.turn_tick = self.turn_tick - 1
	    default.turn(self, state)

	    return true
	 end
      end,

      turnTick = function (self)
	 self.turn_tick = self.turn_tick + self.speed
      end,

      update = default.update or function(self, dt)
	 return self:__update(dt)
      end,
      
      draw = default.draw or function (self)
	 self.sprite:draw(self.px, self.py)
      end,

      move = function (self, dir)
	 if dir == "up" then
	    self.new_pos = { x = self.px, y = self.py - 32 }
	 
	    self.to_move.y = 32
	    self.y = self.y - 1
	    
	    self.sprite:setAnimation("up")
	 elseif dir == "down" then
	    self.new_pos = { x = self.px, y = self.py + 32 }

	    self.to_move.y = -32
	    self.y = self.y + 1

	    self.sprite:setAnimation("down")
	 elseif dir == "right" then
	    self.new_pos = { x = self.px + 32, y = self.py }

	    self.to_move.x = 32
	    self.x = self.x + 1

	    self.sprite:setAnimation("right")
	 elseif dir == "left" then
	    self.new_pos = { x = self.px - 32, y = self.py }

	    self.to_move.x = -32
	    self.x = self.x - 1

	    self.sprite:setAnimation("left")
	 end
      end,

      takeDamage = default.takeDamage or function (self, amount)
	 self.health = self.health - amount

	 if self.health <= 0 then
	    self.die()
	    return
	 end
      end,

      heal = default.heal or function (self, amount, overheal)
	 -- Alter amount to not go over max health
	 if self.health + amount > self.max_health then
	    local overflow = (self.health + amount) - self.max_health
	    amount = amount - overflow
	 end

	 self.health = self.health + amount
      end,

      __update = function (self, dt)
	 self.sprite:update(dt)

	 -- Update movement
     	 if self.to_move.x ~= 0 then
	    if self.to_move.x > 0 then
	       self.px = self.px + 1
	       self.to_move.x = self.to_move.x - 1
	    else
	       self.px = self.px - 1
	       self.to_move.x = self.to_move.x + 1
	    end
	 elseif self.to_move.y ~= 0 then
	    if self.to_move.y > 0 then
	       self.py = self.py - 1
	       self.to_move.y = self.to_move.y - 1
	    else
	       self.py = self.py + 1
	       self.to_move.y = self.to_move.y + 1
	    end
	 end

	 -- Ensure end pos
	 if self.to_move.x == 0 and self.to_move.y == 0 then
	    self.px = self.new_pos.x
	    self.py = self.new_pos.y
	    
	    self.sprite:setAnimation("stationary")
	 
	    return true
	 end
      end
   }
end
			  
return {
   load = load,
   newInstance = newInstance
}
