# frozen_string_literal: true

require_relative 'pattern'

# Responsible for deciphering the code
class Codebreaker
  attr_reader :guess, :player_type
  attr_accessor :game

  def initialize(player_type = 'user')
    @player_type = player_type
    @possible_guesses = Pattern.possible_patterns
    @guess = nil
  end

  def guess!
    return @guess = user_guess if @player_type == 'user'

    @guess = computer_guess
    update_guesses

    sleep 1
    puts @guess.join(' ')
  end

  private

  def user_guess
    Pattern.create_user_pattern
  end

  def computer_guess
    @possible_guesses.sample
  end

  def update_guesses
    return if game.feedback == 'Game won'

    dummy_codemaker = Codemaker.new(@guess)
    @possible_guesses.keep_if { |guess| dummy_codemaker.answer(guess) == game.feedback }
  end
end
