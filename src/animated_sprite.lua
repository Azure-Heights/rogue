local sprite_bank = { }
local image_bank = { }

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

local function newInstance(args)
   -- Create new instance from sprite bank
   local instance =  {
      sprite = sprite_bank[args.name],

      curr_animation = sprite_bank[args.name].animations.stationary,
      curr_frame = 1,
      ct = 0,

      rotation = args.rotation or 0
   }
   
   instance.draw = function(self, x, y)
      -- Draw with position adjustments
      love.graphics.draw(image_bank[self.sprite.sheet],
			 self.curr_animation[self.curr_frame],
			 x - 16, y - 16, self.rotation, 1, 1, 16, 16)
   end

   instance.update = function(self, dt)
      -- Update current frame time, advance if ct > frame duration
      self.ct = self.ct + dt
      if self.sprite.frame_duration and self.ct > self.sprite.frame_duration then
	 self.ct = 0
	 self.curr_frame = self.curr_frame + 1
	 if self.curr_frame > #self.curr_animation then
	    self.curr_frame = 1
	 end
      end
   end

   instance.setAnimation = function(self, animation)
      -- Reset frame count, change animation
      self.curr_frame = 1
      
      self.curr_animation = self.sprite.animations[animation]
   end

   return instance
end

return {
   load = load,
   newInstance = newInstance
}
