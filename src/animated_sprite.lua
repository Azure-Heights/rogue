local Sprite = { }

local sprite_bank = { }
local image_bank = { }

local sprite_prototype = {
   draw = function(self, x, y)
      -- Draw with position adjustments
      love.graphics.draw(image_bank[self.sprite.sheet],
			 self.curr_animation[self.curr_frame],
			 x - self.x_offset, y - self.y_offset, self.rotation, 1, 1, 16, 16)
   end,

   update = function(self, dt)
      -- Update current frame time, advance if ct > frame duration
      self.ct = self.ct + dt
      if self.sprite.frame_duration and self.ct > self.sprite.frame_duration then
	 self.ct = self.ct - self.sprite.frame_duration
	 self.curr_frame = self.curr_frame + 1

	 if self.curr_frame > #self.curr_animation then
	    self.curr_frame = 1
	 end
      end
   end,

   setAnimation = function(self, animation)
      -- Reset frame count, change animation
      self.curr_frame = 1
      
      self.curr_animation = self.sprite.animations[animation]
   end
}

local function load(sprite_def)
   -- Exit if no sprite path given
   if sprite_def == nil then return nil end

   -- Load sprite path
   local def_file = loadfile(sprite_def)
   
   if def_file == nil then
      print("Attempt to load invalid file: "..sprite_def)
      return nil
   end

   -- Add sprite to sprite bank
   local sprite = def_file()
   sprite_bank[sprite.name] = sprite

   -- Add sprite sheet to image bank
   local sprite_sheet = sprite_bank[sprite.name].sheet

   image_bank[sprite_sheet] = love.graphics.newImage(sprite_sheet)

   return sprite_bank[sprite.name]
end
Sprite.load = load

local function newInstance(args)
   -- Create new instance from sprite bank
   default = sprite_bank[args.name]
   
   local instance =  {
      sprite = default,

      x_offset = default.x_offset or 16,
      y_offset = default.y_offset or 16,

      curr_animation = default.animations.stationary,
      curr_frame = 1,
      ct = 0,

      rotation = args.rotation or 0
   }

   for k, v in pairs(sprite_prototype) do
      instance[k] = v
   end
   
   return instance
end
Sprite.newInstance = newInstance

return Sprite
