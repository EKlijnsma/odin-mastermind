require_relative 'clue'
require_relative 'guess'
require_relative 'peg_sequence'
require_relative 'peg'
require_relative 'pin'
require_relative 'player'
require_relative 'secret'

class Game
  @@MAX_ROUNDS = 12
  @@COLORS = [:red, :light_green, :light_yellow, :blue, :grey, :light_magenta, :light_red, :white]

  def initialize
    self.win = false
  end

  def play
    # Generate secret
    secret = Secret.new(@@COLORS)
    
    # Generate player
    player = Player.new
    
    # List colors with numbers
    @@COLORS.each_with_index { |color, i| puts "#{i} is for #{color}" }
  
    # Game loop
    @@MAX_ROUNDS.times do |i|
      puts "---ROUND #{i}---".colorize(:red)
      guess = player.make_guess(@@COLORS)
      clue = secret.evaluate_guess(guess)
      if (secret.hidden? == false)
        self.win = true
        break
      end
      puts "Your guess: #{guess} - Computer responds: #{clue}"
    end

    self.announce_end
  end

  
  def announce_end
    win ? "You won!" : "You lost, the secret code was #{secret}"
  end

  attr_accessor :win
end 