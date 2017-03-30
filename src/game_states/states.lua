local states = {
   main = require "src.game_states.main.init",
   menu = require "src.game_states.menu.init"
}

-- Load each game state
for state, entry in pairs(states) do
   entry.input = require("src.game_states."..state..".input")
end

states.current = states.main

return states
