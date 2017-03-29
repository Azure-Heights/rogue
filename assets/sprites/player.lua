require "love.graphics"

local image_w = 96
local image_h = 128

return {
   name = "mage",
   sheet = "assets/sprites/player.png",
   
   frame_duration = .12,

   animations = {
      down = {
	 love.graphics.newQuad(0, 0, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 0, 32, 32, image_w, image_h),
	 love.graphics.newQuad(64, 0, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 0, 32, 32, image_w, image_h)
      },
      
      left = {
	 love.graphics.newQuad(0, 32, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 32, 32, 32, image_w, image_h),
	 love.graphics.newQuad(64, 32, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 32, 32, 32, image_w, image_h)
      },
      
      right = {
	 love.graphics.newQuad(0, 64, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 64, 32, 32, image_w, image_h),
	 love.graphics.newQuad(64, 64, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 64, 32, 32, image_w, image_h)
      },
      
      up = {
	 love.graphics.newQuad(0, 96, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 96, 32, 32, image_w, image_h),
	 love.graphics.newQuad(64, 96, 32, 32, image_w, image_h),
	 love.graphics.newQuad(32, 96, 32, 32, image_w, image_h)
      },

      stationary = {
	 love.graphics.newQuad(32, 0, 32, 32, image_w, image_h)
      }
   }
}
