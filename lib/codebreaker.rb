# frozen_string_literal: true

require_relative 'pattern'

# Responsible for deciphering the code
class Codebreaker
  attr_reader :guess, :player_type

  def initialize(player_type = 'user')
    @player_type = player_type
    @guess = nil
  end

  def guess!
    return @guess = user_guess if @player_type == 'user'

    @guess = computer_guess
    sleep 1
    puts @guess.pattern.join(' ')
  end

  private

  def user_guess
    Pattern.create_user_pattern
  end

  def computer_guess
    Pattern.new
  end
end
