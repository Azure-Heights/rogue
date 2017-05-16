local ai = require "src.ai"
local state = require "src.game_states.main.state"

return {
   name = "eyeball",
   sprite_name = "eyeball",
   
   movement = "flying",

   health = 50,
   speed = .25,

   turn = function (self)
      local dir = ai.getDirectionTo(self, player.x, player.y)
      
      local dist_x, dist_y, dist = ai.getDistance(self, player.x, player.y)

      if math.abs(dist_x + dist_y) == 1 then
	 local axis = math.abs(dist_x) == utils.dirs.right.x and utils.axes.x or utils.axes.y
	 local dir = dist_x + dist_y == 1 and axis.positive or axis.negative

	 self:attack(dir)
      elseif dist > 5 then
	 state:moveEntity(self, dir)
      else
	 state:moveEntity(self, ai.getReverse(dir))
      end
   end
}
