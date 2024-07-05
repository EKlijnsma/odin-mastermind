# frozen_string_literal: true

require_relative 'lib/game'

game = Game.new
game.break? ? game.play_break : game.play_make
