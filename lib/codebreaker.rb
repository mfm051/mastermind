# frozen_string_literal: true

require_relative 'pattern'

# Responsible for deciphering the code
class Codebreaker
  attr_reader :guess

  def initialize(player_type = 'user')
    @player_type = player_type
    @guess = nil
  end

  def guess!
    @guess = @player_type == 'user' ? user_guess : computer_guess
  end

  private

  def user_guess
    puts 'Enter a four-letter sequence with letters between "A" and "H"'
    begin
      user_input = gets.chomp.upcase.delete(' ').split('')
      @guess = Pattern.new(user_input)
    rescue ArgumentError => e
      puts e.message
      retry
    end
  end

  def computer_guess
    Pattern.new
  end
end
