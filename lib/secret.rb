require_relative 'clue'
require_relative 'peg_sequence'
require_relative 'peg'
require_relative 'pin'

class Secret < PegSequence
  def initialize(colors)
    super([])
    4.times { sequence.push(Peg.new(colors.sample)) }
    @hidden = true
  end

  def hidden?
    @hidden
  end

  def to_s
    hidden? ? '❔❔❔❔' : super
  end

  def evaluate_guess(guess)
    # Deep copy of the secret sequence
    secret_copy = sequence.map(&:dup)
    first_results = check_color_and_positions(guess.sequence, secret_copy)
    # Unhide the secret if all 4 pegs are guessed
    @hidden = false if first_results[:feedback].length == 4
    second_results = check_color(first_results[:guess], first_results[:secret])
    
    # Combine black and white pins for feedback and add question marks if required for a total of 4 items.
    feedback = first_results[:feedback].concat(second_results)
    (4 - feedback.length).times { feedback.push '❔' }
    
    # Shuffle the order and return a clue instance
    Clue.new(feedback.shuffle)
  end

  private

  def check_color_and_positions(sequence1, sequence2)
    feedback = []
    sequence1.each_with_index do |guess_peg, index|
      secret_peg = sequence2[index]
      next unless guess_peg.color == secret_peg.color

      feedback.push Pin.new(:black)
      sequence1[index] = nil
      sequence2[index] = nil
    end
    # Remove nil values for the next check
    { feedback: feedback, guess: sequence1.compact, secret: sequence2.compact }
  end

  def check_color(guess_sequence, secret_sequence)
    feedback = []
    secret_sequence.each do |secret_peg|
      feedback.push Pin.new(:white) if guess_sequence.any? { |guess_peg| guess_peg.color == secret_peg.color }
    end
    feedback
  end

  attr_accessor :hidden
  attr_reader :sequence
end