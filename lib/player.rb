require_relative 'guess'
require_relative 'peg'

class Player
  def make_guess(colors)
    # List colors with numbers
    colors.each_with_index { |color, i| puts "#{i} is for #{color}" }
  
    # Prompt user to enter a 4-digit number once
    puts "Enter a 4-digit number that represents your guess (e.g., 0123):"
    input = gets.chomp

    # Validate the input to ensure it is exactly 4 digits
    until input.match?(/^\d{4}$/)
      puts "Invalid input. Please enter exactly 4 digits:"
      input = gets.chomp
    end

    # Convert the input into an array of digits and map them to the corresponding colors
    new_guess = input.split('').map { |digit| Peg.new(colors[digit.to_i]) }

    # Return a new Guess instance
    Guess.new(new_guess)
  end
end
