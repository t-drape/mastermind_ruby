# frozen_string_literal: true

# MasterMind Pseudocode

# Step 1:
# “Build the game assuming the computer randomly selects the secret colors, and the human player must guess them.
#  Remember that you need to give the proper feedback 	on  how good the guess was each turn!”

#     - [x] Create PlayGame function/class
#         - [x] Set ACCEPTABLE_COLORS to six colors, (blue, red, orange, yellow, purple, green)
#         - [x] Let computer generate random four color code, (blue, red, orange, yellow, purple, green)
#         - [x] Define PlayGame to PlayRound 12 times
#             - [x] If winner, exit loop, print congratulatory message
#             - [x] Else, continue until 12, then print loser message
#         - [x] PlayRound
#             - [x] Set black_dot_variable to 0
#             - [x] Set white_dot_variable to 0
#             - [x] Get User Guess
#             - [x] Compare User Guess to random color code
#             - [x] If equal, declare winner
#             - [x] Else,
#                 - [x] If any color from guess in color code,
#                     - [x] For each color in user guess,
#                         - [x] If guess is correct color and position,
#                             - [x] Increase black_dot by one
#                         - [x] Else if guess is correct color but wrong position,
#                             - [x] Increase white_dot by one
#                         - [x] Else do nothing
#                 - [x] Else, continue loop
# Step 2:
# “Now refactor your code to allow the human player to choose whether they want to be the creator of the secret code
# or the guesser.”
#     - [x] Update PlayGame
#         - [x] Create true/false boolean value is_guesser
#         - [x] Ask user “Do you want to be the guesser? [Y/N] ”
#         - [x] Get user input
#             - [x] If Y,
#                 - [x] PlayGame as normal
#             - [x] If N,
#                 - [x] Ask user for color code
#                 - [x] If any color not in ACCEPTABLE_COLORS, re ask until code is acceptable
#                 - [x]  PlayGame with updated logic, see Step 3.
#             - [x] Else re-ask, with message, “Invalid. Do you want to be the guesser? [Y/N] ”

# Step 3:
# “Build it out so that the computer will guess if you decide to choose your own secret color.”
#     - [x] Model Mastermind strategy
#     - [x] After each guess,
#     - [x] Learn from last guesses,
#     - [x] Make more educated guess
#     - [x] Make computer beatable, but not easy (medium)
#     - [x] Create game logic
#     - [x] Play 12 Rounds as normal

ACCEPTABLE_COLORS = %w[blue red orange yellow purple green].freeze

# Module to evaluate each round of play for MasterMind Project
module Evaluating
  def double_matches_delete(delete_indexes, guess, color_code)
    delete_indexes = delete_indexes.reverse
    delete_indexes.each do |index|
      guess.delete_at(index)
      color_code.delete_at(index)
    end
    [guess, color_code]
  end

  def double_matches(guess, color_code)
    indexes = []
    guess.each_with_index do |color, index|
      next unless color == color_code[index]

      indexes << index
    end
    indexes
  end

  def single_match(guess, color_code, w_dots)
    guess.each do |color|
      color_code.each_with_index do |computer_color, computer_index|
        next unless color == computer_color

        w_dots += 1
        color_code.delete_at(computer_index)
        break
      end
    end
    w_dots
  end

  def compare_codes(user_guess, random_color_code, b_dots, w_dots)
    # Try removing elements from array once a match is hit
    # Work on clone to not permanently remove elements from original

    guess = user_guess.clone
    color_code = random_color_code.clone

    delete_indexes = double_matches(guess, color_code)

    b_dots += delete_indexes.length

    guess, color_code = double_matches_delete(delete_indexes, guess, color_code)

    w_dots = single_match(guess, color_code, w_dots)

    [b_dots, w_dots]
  end
end

# A single class to hold all gameplay for MasterMind Project!
class Game
  def initialize
    puts "What is Your Name? "
    @user = User.new(gets.chomp)
  end

  def introduce
    puts "++++Hi there! Welcome to MasterMind!++++"
    puts "++++The goal of this game is for one person to guess the other's code!++++"
    puts "++++In this version, you can either build your code for the computer to guess...++++"
    puts "++++Or try to guess the computer's random code!++++"
    puts "++++Please choose your path forward at the prompt: ++++"
    @user.initialize_choice
  end

  def play_game
    introduce
    if @user.choice
      comp = Computer.new(@user.choice)
      comp.computer_guessing_user_code(@user.code)
      @user.is_winner = !comp.is_winner
      @user.ending_message
    else
      @user.user_guessing_computer_code
    end
  end
end

MASTERMIND = Game.new
MASTERMIND.play_game
