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

    code_letters = @code.uniq.to_h { |letter| [letter, @code.each_index.select { |i| @code[i] == letter }] }
    guess_letters = guess.uniq.to_h { |letter| [letter, guess.each_index.select { |i| guess[i] == letter }] }

    guess_letters.each_pair do |letter, positions|
      next unless code_letters.include?(letter)

      right_positions = positions.intersection(code_letters[letter])
      guess_residual_positions = guess_letters[letter] - right_positions
      hint_residual_positions = code_letters[letter] - right_positions

      right_count += right_positions.count
      almost_count += [guess_residual_positions.count, hint_residual_positions.count].min
    end

    { right: right_count, almost_count: almost_count }
  end
end
