require 'colorize'
require_relative 'lib/secret'
require_relative 'lib/guess'
require_relative 'lib/player'

MAX_ROUNDS = 12
COLORS = [:red, :light_green, :light_yellow, :blue, :grey, :light_magenta, :light_red, :white]

# new secret
secret = Secret.new(COLORS)
# new player
player = Player.new
# play game
puts secret
