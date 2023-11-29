# frozen_string_literal: true

# Responsible for Mastermind patterns
class Pattern
  attr_reader :pattern

  def initialize(pattern = random_pattern)
    raise(ArgumentError, 'Invalid pattern') unless valid_pattern?(pattern)

    @pattern = pattern
  end

  def self.create_user_pattern
    puts 'Enter a four-letter sequence with letters between "A" and "F"'
    begin
      user_input = gets.chomp.upcase.delete(' ').split('')
      Pattern.new(user_input)
    rescue ArgumentError => e
      puts e.message
      retry
    end
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
    ('A'..'F').to_a
  end

  def random_pattern
    Array.new(4).map { valid_letters.sample }
  end

  def valid_pattern?(pattern)
    pattern.is_a?(Array) && pattern.length == 4 && pattern.all? { |letter| valid_letters.include?(letter) }
  end
end
