# frozen_string_literal: true

require_relative 'lib/codemaker'
require_relative 'lib/codebreaker'

# Controls game
class Mastermind
  def initialize
    setup_game

    @codebreaker.game = self
    @rounds_left = 12
  end

  def start_game
    until end_of_game?
      round
      puts feedback
      puts "#{@rounds_left} rounds remaining" unless end_of_game?
    end
  end

  def feedback
    return nil unless @codebreaker.guess
    return 'Game won' if @codemaker.answer(@codebreaker.guess) == 'Right guess'
    return 'Game lost' if @rounds_left.zero?

    @codemaker.answer(@codebreaker.guess)
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
      @codemaker = Codemaker.user_code
      @codebreaker = Codebreaker.new('computer')
    else
      @codemaker = Codemaker.computer_code
      @codebreaker = Codebreaker.new('user')
    end
  end

  def round
    @codebreaker.guess!
    @rounds_left -= 1
  end

  def end_of_game?
    @codebreaker.guess && (feedback == 'Game won' || feedback == 'Game lost')
  end
end

# Game

mastermind = Mastermind.new
mastermind.start_game
