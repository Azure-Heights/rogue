local game_state = require "src.game_state"

game_state.main = require "src.game_states.main.init"
game_state.menu = require "src.game_states.menu.init"

game_state.current = game_state.main

return game_state
