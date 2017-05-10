require "love.graphics"

local state = require "src.game_states.menu.state"
state.input = require "src.game_states.menu.input"

local menu_font = love.graphics.newFont("assets/fonts/future_time_splitters.otf", 75)

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

function state.draw(self, width, height)
   for i, option in ipairs(state.current) do
      text = option.text
      
      if i == state.selection then love.graphics.setColor(110, 110, 110) end
      
      love.graphics.draw(text, (width / 2) - (text:getWidth() / 2), i * 100 + 50)

      love.graphics.setColor(255, 255, 255)
   end
end

function state.inputHandler(self, game_state, k)
   local action = state.input.keys[k]
      
   if action then
      state.input.bindings[action](game_state)
   end
end

return state
