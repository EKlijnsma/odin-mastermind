# frozen_string_literal: true

require_relative 'guess'
require_relative 'peg'

class HumanPlayer
  def make_guess(colors)
    # Prompt user to enter a 4-digit number once
    print '| Enter new guess: '
    input = gets.chomp

    # Validate the input to ensure it is exactly 4 digits
    until input.match?(/^\d{4}$/)
      puts 'Invalid input. Please enter exactly 4 digits:'
      input = gets.chomp
    end

    # Convert the input into an array of digits and map them to the corresponding colors
    new_guess = input.chars.map { |digit| Peg.new(colors[digit.to_i]) }

    # Return a new Guess instance
    Guess.new(new_guess)
  end
end
