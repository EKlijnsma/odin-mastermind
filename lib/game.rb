# frozen_string_literal: true

require_relative 'clue'
require_relative 'guess'
require_relative 'peg_sequence'
require_relative 'peg'
require_relative 'pin'
require_relative 'human_player'
require_relative 'cpu_player'
require_relative 'secret'

class Game
  def initialize
    self.win = false
    self.max_rounds = 12
    self.colors = %i[red light_green light_yellow blue grey light_magenta light_red white]
  end

  def break?
    print 'You can choose to MAKE or BREAK the secret code. Do you want to BREAK? (y/n)'
    input = gets.chomp

    # Validate the input to ensure it is exactly 4 digits
    until input.downcase == 'y' || input.downcase == 'n'
      puts "Invalid input. Please enter 'y' or 'n'.\nDo you want to BREAK? (y/n)"
      input = gets.chomp
    end

    input.downcase == 'y'
  end

  def play_break
    # Generate human player
    player = HumanPlayer.new

    # Generate secret
    secret = Secret.new(@colors)
    secret.random(@colors)

    # List colors with numbers
    puts 'Use the following digits for inputting their corresponding colors:'
    @colors.each_with_index { |color, i| print "- #{i.to_s.colorize(color)} -" }
    puts

    # Game loop
    @max_rounds.times do |_i|
      guess = player.make_guess(@colors)
      clue = secret.evaluate_guess(guess)
      if secret.hidden? == false
        self.win = true
        break
      end
      print "Guess: #{guess} | Clue: #{clue}"
    end
    puts
    puts announce_end(secret)
  end

  def announce_end(secret)
    secret.reveal
    win ? "You won, the secret code was #{secret}" : "You lost, the secret code was #{secret}"
  end

  def play_make
    # Generate secret
    secret = Secret.new(@colors)
    secret.input(@colors)

    # Generate CPU player
    player = CpuPlayer.new

    # Game loop
    @max_rounds.times do |_i|
      guess = player.make_guess(@colors)
      clue = secret.evaluate_guess(guess)
      if secret.hidden? == false
        self.win = true
        break
      end
      puts "Guess: #{guess} | Clue: #{clue}"
    end
    puts announce_end(secret)
  end

  def announce_end(secret)
    secret.reveal
    win ? "You won, the secret code was #{secret}" : "You lost, the secret code was #{secret}"
  end

  attr_accessor :win, :max_rounds, :colors
end
