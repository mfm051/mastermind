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

      right_locations = guess.letter_locations(letter).intersection(@code.letter_locations(letter))
      guess_residual_locations = guess.letter_locations(letter) - right_locations
      hint_residual_locations = @code.letter_locations(letter) - right_locations

      right_count += right_locations.count
      almost_count += [guess_residual_locations.count, hint_residual_locations.count].min
    end

    { right: right_count, almost: almost_count }
  end
end
