# frozen_string_literal: true

# Responsible for Mastermind patterns
class Pattern
  def initialize(pattern = random_pattern)
    raise(ArgumentError, 'Invalid pattern') unless valid_pattern?(pattern)

    @pattern = pattern
  end

  def self.create_random_pattern
    Pattern.new
  end

  def letters
    @pattern.uniq
  end

  def letter_locations(letter)
    @pattern.each_index.select { |i| @pattern[i] == letter }
  end

  def locations_intersection(letter, another_pattern)
    letter_locations(letter).intersection(another_pattern.letter_locations(letter))
  end

  def count(letter)
    @pattern.count(letter)
  end

  private

  def valid_letters
    ('A'..'H').to_a
  end

  def random_pattern
    Array.new(4).map { valid_letters.sample }
  end

  def valid_pattern?(pattern)
    pattern.is_a?(Array) && pattern.length == 4 && pattern.all? { |letter| valid_letters.include?(letter) }
  end
end
