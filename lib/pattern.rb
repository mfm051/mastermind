# frozen_string_literal: true

# Class responsible for patterns of Masterming
class Pattern
  def initialize(pattern = random_pattern)
    @pattern = pattern
  end

  def self.create_random_pattern
    Pattern.new
  end

  def letter_locations(letter)
    @pattern.each_index.select { |i| @pattern[i] == letter }
  end

  def letters
    @pattern.uniq
  end

  def locations_intersection(letter, another_pattern)
    self.letter_locations(letter).intersection(another_pattern.letter_locations(letter))
  end

  def count(letter)
    @pattern.count(letter)
  end

  private

  def random_pattern
    Array.new(4).map { ('A'..'H').to_a.sample }
  end
end
