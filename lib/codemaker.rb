# frozen_string_literal: true

require_relative 'pattern'

# Responsible for managing the secret sequence of mastermind
class Codemaker
  def initialize(code)
    @code = code
  end

  def self.computer_code
    Codemaker.new(Pattern.new)
  end

  def self.user_code
    Codemaker.new(Pattern.create_user_pattern)
  end

  def answer(guess)
    return 'Right guess' if hint(guess)[:right] == 4

    hint(guess)
  end

  private

  def hint(guess)
    total_right_count = 0
    total_almost_count = 0

    guess.letters.each do |letter|
      next unless @code.letters.include?(letter)

      right_count = guess.locations_intersection(letter, @code).count
      almost_count = [guess.count(letter), @code.count(letter)].min - right_count

      total_right_count += right_count
      total_almost_count += almost_count
    end

    { right: total_right_count, almost: total_almost_count }
  end
end
