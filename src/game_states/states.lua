local states = {
   main = require "src.game_states.main.init",
   menu = require "src.game_states.menu.init"
}

states.current = states.main

return states
