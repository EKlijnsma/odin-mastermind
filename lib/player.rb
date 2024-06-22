require_relative 'guess'
require_relative 'peg'

class Player
  def make_guess(colors)
    new_guess = []
    colors.each_with_index { |color, i| puts "#{i} is for #{color}" }
    4.times do |i|
      puts "Make your choice for position #{i + 1}"
      new_guess.push(get_input(colors))
    end
    puts new_guess.map { |peg| peg.to_s }.join(' ')
    Guess.new(new_guess)
  end

  private
  
  def get_input(colors)
    while (guess = gets.chomp.to_i)
      return Peg.new(colors[guess]) if guess >= 0 && guess <= colors.length

      puts 'Invalid move, try again!'

    end
  end
end
