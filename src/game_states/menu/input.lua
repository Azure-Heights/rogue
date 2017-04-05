state = require "src.game_states.menu.init"

local keys = {
   w = "prev_selection",
   s = "next_selection",
   
   tab  = "choose_selection",
   ["return"] = "choose_selection",
   
   escape = "exit_menu"
}

local bindings = {
   prev_selection = function ()
      -- If selection is the first option, don't change
      if state.selection > 1 then
	 state.selection = state.selection - 1
      end
   end,

   next_selection = function ()
      -- If selection is the last option, don't change
      if state.selection < #state.current then
	 state.selection = state.selection + 1
      end
   end,

   choose_selection = function (game_state)
      state.current[state.selection].action(game_state)
   end,

   exit_menu = function (game_state)
      game_state.current = game_state.main
   end
}

return {
   keys = keys,
   bindings = bindings
}
