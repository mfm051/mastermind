# frozen_string_literal: true

# Class responsible for patterns of Masterming
class Pattern
  def initialize(pattern = random_pattern)
    @pattern = pattern
  end

  def self.create_random_pattern
    Pattern.new
  end

  private

  def random_pattern
    Array.new(4).map { ('A'..'H').to_a.sample }
  end
end
