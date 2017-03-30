require "love.graphics"

local menu_font = love.graphics.newFont("assets/fonts/future_time_splitters.otf", 75)

local state = { }

state.pause_menu = {
   { text = love.graphics.newText(menu_font, "Resume"),
     action = function (game_state)
	game_state.current = game_state.main
     end
   },
   
   { text = love.graphics.newText(menu_font, "Main Menu"),
     action = function ()

     end
   },
   
   { text = love.graphics.newText(menu_font, "Quit"),
     action = function () 
	love.event.quit()
     end
   }
}

state.current = state.pause_menu
state.selection = 1

function state.update(dt)
   
end

function state.draw(width, height)
   for i, option in ipairs(state.current) do
      text = option.text
      
      if i == state.selection then love.graphics.setColor(110, 110, 110) end
      
      love.graphics.draw(text, (width / 2) - (text:getWidth() / 2), i * 100 + 50)

      love.graphics.setColor(255, 255, 255)
   end
end

return state
