# frozen_string_literal: true

require_relative 'pattern'

# Responsible for deciphering the code
class Codebreaker
  def initialize
    @guess = nil
  end

  def user_guess
    user_input = gets.chomp.upcase.delete(' ').split('')
    begin
      @guess = Pattern.new(user_input)
    rescue ArgumentError => e
      puts e.message
    end
  end
end
