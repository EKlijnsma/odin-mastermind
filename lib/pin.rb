# frozen_string_literal: true

require_relative 'peg'

class Pin < Peg
  def to_s
    '•'.colorize(color)
  end
end
