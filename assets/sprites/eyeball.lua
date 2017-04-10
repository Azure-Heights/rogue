require "love.graphics"

local image_w = 96
local image_h = 152

return {
   name = "eyeball",
   sheet = "assets/sprites/eyeball.png",
   
   frame_duration = .12,

   x_offset = 16,
   y_offset = 22,

   animations = {
      up = {
	 love.graphics.newQuad(0, 0, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 0, 32, 38, image_w, image_h),
	 love.graphics.newQuad(64, 0, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 0, 32, 38, image_w, image_h)
      },
      
      left = {
	 love.graphics.newQuad(0, 38, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 38, 32, 38, image_w, image_h),
	 love.graphics.newQuad(64, 38, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 38, 32, 38, image_w, image_h)
      },
      
      down = {
	 love.graphics.newQuad(0, 76, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 76, 32, 38, image_w, image_h),
	 love.graphics.newQuad(64, 76, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 76, 32, 38, image_w, image_h)
      },
      
      right = {
	 love.graphics.newQuad(0, 114, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 114, 32, 38, image_w, image_h),
	 love.graphics.newQuad(64, 114, 32, 38, image_w, image_h),
	 love.graphics.newQuad(32, 114, 32, 38, image_w, image_h)
      },

      stationary = {
	 love.graphics.newQuad(0, 76, 32, 38, image_w, image_h)
      }
   }
}
