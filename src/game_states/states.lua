local states = {
   main = { }
}

-- Load each game state
for state, entry in pairs(states) do
   entry.input = require("src.game_states."..state..".input")
end

return states
