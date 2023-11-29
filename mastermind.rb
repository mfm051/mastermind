# frozen_string_literal: true

require_relative 'lib/codemaker'
require_relative 'lib/codebreaker'

# Controls game
class Mastermind
  def initialize
    setup_game
    @rounds_left = 12
  end

  def full_game
    round until end_of_game?
  end

  private

  def setup_game
    puts "--Mastermind--\n\nBreak the code or Make the code?\n\n1: break\n2: make\n\n"
    game_options = { player_codebreaker: '1', player_codemaker: '2' }
    begin
      user_option = gets.chomp
      pick_game_mode(game_options.key(user_option))
    rescue ArgumentError => e
      puts e.message
      retry
    end
  end

  def pick_game_mode(option)
    raise ArgumentError, 'Invalid option' unless %i[player_codebreaker player_codemaker].include?(option)

    if option == :player_codebreaker
      @codemaker = Codemaker.random_code
      @codebreaker = Codebreaker.new
    else
      @codemaker = Codemaker.new(Pattern.create_user_pattern)
      @codebreaker = Codebreaker.new('computer')
    end
  end

  def round
    @codebreaker.guess!
    puts @codemaker.answer(@codebreaker.guess)
    @rounds_left -= 1
    puts "#{@rounds_left} rounds remaining"
  end

  def end_of_game?
    @rounds_left.zero? || @current_guess && @codemaker.answer(@current_guess) == 'Right guess'
  end
end

# Test

game = Mastermind.new
game.full_game
