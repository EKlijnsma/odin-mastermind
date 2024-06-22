class PegSequence
  def initialize(peg_array)
    @sequence = peg_array
  end

  def to_s
    @sequence.map { |peg| peg.to_s }.join(' ')
  end

  attr_reader :sequence
end
