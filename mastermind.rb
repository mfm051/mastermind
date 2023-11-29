# frozen_string_literal: true

require_relative 'lib/codemaker'
require_relative 'lib/codebreaker'

# Controls game
class Mastermind
  def initialize
    @codemaker = Codemaker.new
    @current_guess = nil
    @rounds_left = 12
  end

  def full_game
    round until end_of_game?
  end

  private

  def round
    @current_guess = user_guess
    puts @codemaker.answer(@current_guess)
    @rounds_left -= 1
    puts "#{@rounds_left} rounds remaining"
  end

  def user_guess
    puts 'Enter a four-letter sequence with letters between "A" and "H"'
    begin
      user_guess = gets.chomp.upcase.delete(' ').split('')
      Pattern.new(user_guess)
    rescue ArgumentError => e
      puts e.message
      retry
    end
  end

  def end_of_game?
    @rounds_left.zero? || @current_guess && @codemaker.answer(@current_guess) == 'Right guess'
  end
end
