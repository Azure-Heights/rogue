local states = {
   main = require "src.game_states.main.init"
}

-- Load each game state
for state, entry in pairs(states) do
   entry.input = require("src.game_states."..state..".input")
end

return states
