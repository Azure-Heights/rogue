return {
   name = "player",
   sprite_name = "mage",

   health = 100,
   
   update = function(self, dt)
      return self:__update(dt)
   end,

   draw = function(self)
      self.sprite:draw(self.x, self.y)
   end
}
