local ai = require "src.ai"

return {
   name = "eyeball",
   sprite_name = "eyeball",
   
   movement = "flying",

   health = 50,
   speed = .5,

   turn = function (self, state)
      local dir = ai.getDirectionTo(self, player.x, player.y)
      
      dist_x, dist_y, dist = ai.getDistance(self, player.x, player.y)

      if dist > 5 then
	 state:moveEntity(self, dir)
      else
	 state:moveEntity(self, ai.getReverse(dir))
      end
   end
}
