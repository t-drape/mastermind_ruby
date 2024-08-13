# frozen_string_literal: true

require_relative "eval"

# Model to represent computer in MasterMind Project
class Computer
  include Evaluating
  attr_accessor :bd, :is_winner

  def initialize(job, colors)
    @choice = !job
    @rounds = 12
    @cca = check_need_for_array
    @bd = 0
    @is_winner = nil
    @current_guess = nil
    @acceptable_colors = colors
  end

  def check_need_for_array
    return nil if @choice

    []
  end

  def shuffled_guesses(code)
    @rounds.times do |time|
      return true if @current_guess == code

      p "---Attempt No: #{12 - (@rounds - time) + 1}---"
      p @cca
      return true if @cca == code

      former = @cca
      @cca = @cca.shuffle until @cca != former
    end
    false
  end

  def single_color_computer_guess(code)
    @acceptable_colors.length.times do |time|
      @rounds -= 1
      puts "---Attempt No: #{time + 1}---"
      @current_guess = Array.new(4, @acceptable_colors[time])
      p @current_guess
      end_game = play_computer_guessing_round(@current_guess, code)
      return @cca if end_game
      next unless @cca.length == 4

      return @cca
    end
  end

  def play_computer_guessing_round(computer_guess, user_code)
    @bd = 0
    computer_evaluate_round(computer_guess, user_code)
    @bd.times do
      @cca << computer_guess[0]
    end
    @bd == 4
  end

  def computer_evaluate_round(guess, color_code)
    computer_compare_codes(guess, color_code) if color_code.any? { |element| guess.include?(element) }
  end

  def computer_compare_codes(user_guess, random_color_codes)
    guess = user_guess.clone
    color_code = random_color_codes.clone

    delete_indexes = double_matches(guess, color_code)

    @bd += delete_indexes.length
  end

  def computer_guessing_user_code(user_provided_code)
    return if @choice

    @cca = single_color_computer_guess(user_provided_code)
    @is_winner = shuffled_guesses(user_provided_code)
  end
end
