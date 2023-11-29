# frozen_string_literal: true

require_relative 'lib/codemaker'
require_relative 'lib/codebreaker'

# Controls game
class Mastermind
  def initialize
    setup_game
    @rounds_left = 12
  end

  def start_game
    until end_of_game?
      round
      @rounds_left -= 1
      puts "#{@rounds_left} rounds remaining"
    end
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

    if option == :player_codemaker
      @codemaker = Codemaker.new(Pattern.create_user_pattern)
      @codebreaker = Codebreaker.new('computer')
    else
      @codebreaker = Codebreaker.new('user')
      @codemaker = Codemaker.computer_code
    end
  end

  def round
    @codebreaker.guess!
    puts @codemaker.answer(@codebreaker.guess)
  end

  def end_of_game?
    @rounds_left.zero? || @codebreaker.guess && @codemaker.answer(@codebreaker.guess) == 'Right guess'
  end
end
