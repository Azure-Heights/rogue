local updates = { }

updates.input = {
   keys = {
      w = "up",
      a = "left",
      s = "down",
      d = "right",
      
      escape = "pause_menu"
   }
}

updates.player = {
   keys = { },
   
   update = function (dt)
      if player:update(dt) then updates.current = updates.input end
   end
}

updates.current = updates.input

return updates
