local Sprite = require "src.animated_sprite"

local entity_bank = { }

local function load(entity_def)
   -- Exit if no entity path given
   if entity_def == nil then return nil end

   -- Load entity path
   local def_file = loadfile(entity_def)

   if def_file == nil then
      print("Attempt to load invalid file: "..sprite_def)
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
   
   return {
      health = default.health or 100,
      max_health = default.health or 100,
      
      x = args.x or 0,
      y = args.y or 0,

      to_move = { x = 0, y = 0 },

      sprite = sprite,

      update = entity_bank[args.name].update,
      draw = entity_bank[args.name].draw,

      goUp = default.goUp or function (self)
	 -- Set variables for new position
	 self.new_pos = { x = self.x, y = self.y - 32 }
	 
	 self.to_move.y = 32
	 self.sprite:setAnimation("up")
      end,

      goDown = default.goDown or function (self)
	 -- Set variables for new position
	 self.new_pos = { x = self.x, y = self.y + 32 }

	 self.to_move.y = -32
	 self.sprite:setAnimation("down")
      end,

      goRight = default.goRight or function (self)
	 -- Set variables for new position
	 self.new_pos = { x = self.x + 32, y = self.y }

	 self.to_move.x = 32
	 self.sprite:setAnimation("right")
      end,

      goLeft = default.goLeft or function (self)
	 -- Set variables for new position
	 self.new_pos = { x = self.x - 32, y = self.y }

	 self.to_move.x = -32
	 self.sprite:setAnimation("left")
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
	       self.x = self.x + 1
	       self.to_move.x = self.to_move.x - 1
	    else
	       self.x = self.x - 1
	       self.to_move.x = self.to_move.x + 1
	    end
	 elseif self.to_move.y ~= 0 then
	    if self.to_move.y > 0 then
	       self.y = self.y - 1
	       self.to_move.y = self.to_move.y - 1
	    else
	       self.y = self.y + 1
	       self.to_move.y = self.to_move.y + 1
	    end
	 end

	 -- Ensure end pos
	 if self.new_pos ~= nil and self.to_move.x == 0 and self.to_move.y == 0 then
	    self.x = self.new_pos.x
	    self.y = self.new_pos.y

	    self.new_pos = nil
	 end

	 if self.to_move.x == 0 and self.to_move.y == 0 then
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
