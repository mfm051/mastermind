# frozen_string_literal: true

require_relative 'pattern'

# Class responsible for managing the secret sequence of mastermind
class Codemaker
  def initialize
    @code = Pattern.create_random_pattern
  end

  def hint(guess)
    right_count = 0
    almost_count = 0

    guess.letters.each do |letter|
      next unless @code.letters.include?(letter)

      right_count += guess.locations_intersection(letter, @code).count
      almost_count += [guess.count(letter), @code.count(letter)].min - right_count
    end

    { right: right_count, almost: almost_count }
  end
end
