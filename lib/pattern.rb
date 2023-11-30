# frozen_string_literal: true

# Responsible for Mastermind patterns
class Pattern < Array
  VALID_LETTERS = ('A'..'F').to_a

  attr_reader :pattern

  def initialize(pattern = random_pattern)
    super
    raise(ArgumentError, 'Invalid pattern') unless valid?(pattern)

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

  def self.possible_patterns
    VALID_LETTERS.product(VALID_LETTERS, VALID_LETTERS, VALID_LETTERS)
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

  private

  def random_pattern
    Array.new(4).map { VALID_LETTERS.sample }
  end

  def valid?(pattern)
    pattern.is_a?(Array) && pattern.length == 4 && pattern.all? { |letter| VALID_LETTERS.include?(letter) }
  end
end
