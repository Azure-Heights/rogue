local state = require "src.game_states.main.state"

local entity_bank = { }

local dirs = {
   up = { x = 0, y = -1 },
   down = { x = 0, y = 1 },
   left = { x = -1, y = 0 },
   right = { x = 1, y = 0 }
}

local function movement_animation (self, dir)
   local dpx = dirs[dir].x
   local dpy = dirs[dir].y

   self.sprite:setAnimation(dir)
   
   coroutine.yield()

   for i = 1, 32 do
      self.px = self.px + dpx
      self.py = self.py + dpy
      coroutine.yield()
   end
   
   self.sprite:setAnimation("stationary")
   
   return true
end

local entity_prototype = {
   turn = function (self)
      if self.turn_tick >= 1 then
	 self.turn_tick = self.turn_tick - 1
	 
	 entity_bank[self.name].turn(self, state)
	 
	 return true
      end
   end,
   
   turnTick = function (self)
      self.turn_tick = self.turn_tick + self.speed
   end,

   update = function(self, dt)
      return self:__update(dt)
   end,
   
   draw = function (self)
      self.sprite:draw(self.px, self.py)
   end,

   move = function (self, dir)
      local anim = coroutine.wrap(movement_animation)
      
      anim(self, dir)
      state:addAnimation(anim)

      self.x = self.x + dirs[dir].x
      self.y = self.y + dirs[dir].y
   end,

   takeDamage = function (self, amount)
      self.health = self.health - amount

      if self.health <= 0 then
	 self.die()
	 return
      end
   end,

   heal = function (self, amount, overheal)
      -- Alter amount to not go over max health
      if self.health + amount > self.max_health then
	 local overflow = (self.health + amount) - self.max_health
	 amount = amount - overflow
      end

      self.health = self.health + amount
   end,

   update = function (self, dt)
      self.sprite:update(dt)
   end
}

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

   instance = { }

   -- Initialize variables/functions from entity file
   for k, v in pairs(entity_bank[args.name]) do
      instance[k] = v
   end
   -- Add pointers to entity functions, allowing overloading from entity file
   for k, v in pairs(entity_prototype) do
      if instance[k] and k ~= "turn" then
	 instance["__" .. k] = entity_prototype[k]
      else
	 instance[k] = entity_prototype[k]
      end
   end

   -- Set defaults, if values were not present in entity file
   if instance.health == nil then instance.health = 100 end
   instance.max_health = instance.health

   if instance.movement == nil then instance.movement = "walking" end
   
   if instance.speed == nil then instance.speed = 1 end

   -- Set variables that depend on instance information
   instance.sprite = sprite

   instance.turn_tick = 0

   instance.x = x / 32
   instance.y = y / 32
      
   instance.px = x
   instance.py = y

   return instance
end
			  
return {
   load = load,
   newInstance = newInstance
}
