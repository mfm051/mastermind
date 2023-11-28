# frozen_string_literal: true

require_relative 'pattern'

# Responsible for deciphering the code
class Codebreaker
  def initialize
    @guess = nil
  end

  def guess_from_user
    puts('Choose a four-letter sequence with letters between "A" and "H"')
    user_guess = gets.chomp.upcase.delete(' ').split('')
    @guess = Pattern.new(user_guess)
  end
end
