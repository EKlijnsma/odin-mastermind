# frozen_string_literal: true

require_relative 'guess'
require_relative 'peg'

class CpuPlayer
  def make_guess(colors)
    new_guess = []
    4.times { new_guess.push(Peg.new(colors.sample)) }
    # Return a new Guess instance
    Guess.new(new_guess)
  end
end
