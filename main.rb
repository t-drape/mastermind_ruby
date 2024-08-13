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

def get_color_code(available_colors)
  random = Random.new
  color_code = []
  4.times { color_code << available_colors[random.rand(5)] }
  color_code
end

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

def user_evaluate_round(guess, color_code, b_dots, w_dots)
  return true if guess == color_code

  if color_code.any? { |element| guess.include?(element) }
    b_dots, w_dots = compare_codes(guess, color_code, b_dots, w_dots)
  end
  p "Correct Color and Position: #{b_dots}"
  p "Correct Color but Wrong Position: #{w_dots}"
  false
end

def play_round(color_code, guess)
  w_dots = 0
  b_dots = 0

  # redo_needed = false

  # guess = user_guess

  # guess = user_guess unless guess.length == 4

  # guess.each do |color|
  #   redo_needed = true unless ACCEPTABLE_COLORS.include?(color)
  # end
  # guess = user_guess if redo_needed

  user_evaluate_round(guess, color_code, b_dots, w_dots)
end

# MAYBE SWITCH TIMES LOOP TO EACH WITH INDEX
# NEED GLOBAL VARIABLE FOR ROUNDS!!!!!!!

# play_game

# Model to represent computer in MasterMind Project
class Computer
  attr_accessor :choice, :correct_color_array, :bd, :is_winner

  def initialize(job)
    @choice = !job
    @rounds = 12
    @cca = check_need_for_array
    @bd = 0
    @is_winner = nil
  end

  def check_need_for_array
    return nil if choice

    []
  end

  def shuffled_guesses(code)
    @rounds.times do |time|
      p "---Attempt No: #{12 - (@rounds - time) + 1}---"
      p @cca
      return true if @cca == code

      former = @cca
      @cca = @cca.shuffle until @cca != former
    end
    false
  end

  def single_color_computer_guess(code)
    ACCEPTABLE_COLORS.length.times do |time|
      @rounds -= 1
      puts "---Attempt No: #{time + 1}---"
      guess = Array.new(4, ACCEPTABLE_COLORS[time])
      p guess
      end_game = play_computer_guessing_round(guess, code)
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
    return if choice

    @cca = single_color_computer_guess(user_provided_code)
    @is_winner = shuffled_guesses(user_provided_code)
  end
end

# Model to represent user in MasterMind Project
class User
  attr_accessor :choice, :code, :is_winner

  def initialize(name)
    @name = name
    @choice = nil
    @is_winner = false
    @code = nil
  end

  def current_code
    @choice ? user_guess : nil
  end

  def initialize_choice
    @choice = user_pick
    @code = current_code
  end

  def check_user_input(code)
    code = user_guess unless code.length == 4
    redo_needed = false
    code.each do |color|
      redo_needed = true unless ACCEPTABLE_COLORS.include?(color)
    end
    code = user_guess if redo_needed
    code
  end

  def user_pick
    puts "Do you want to create the code? [Y/N] "
    user_choice = gets.chomp.upcase
    user_pick unless %w[Y N].include?(user_choice)
    user_choice == "Y"
  end

  def opening_message
    message = @choice ? "code" : "guess"
    puts "What's your four-color #{message}? (ex: blue, blue, blue, blue)"
    puts "Available Colors: blue, red, orange, yellow, purple, green "
  end

  def user_guess
    guess = []
    opening_message
    4.times do |time|
      puts "Color #{time + 1}: "
      guess << gets.chomp
    end
    check_user_input(guess)
  end

  def ending_message
    message = @is_winner ? "#{@name.upcase}, you beat the computer!" : "#{@name.upcase}, the computer won!"
    puts message
  end

  def get_color_code(available_colors)
    random = Random.new
    color_code = []
    4.times { color_code << available_colors[random.rand(5)] }
    color_code
  end

  def user_guessing_computer_code
    color_code = get_color_code(ACCEPTABLE_COLORS)
    12.times do |time|
      puts "---Attempt No: #{time + 1}---"
      @is_winner = user_evaluate_round(user_guess, color_code, 0, 0)
      break if @is_winner
    end
    p color_code
    ending_message
  end

  def user_evaluate_round(guess, color_code, b_dots, w_dots)
    return true if guess == color_code

    if color_code.any? { |element| guess.include?(element) }
      b_dots, w_dots = compare_codes(guess, color_code, b_dots, w_dots)
    end
    p "Correct Color and Position: #{b_dots}"
    p "Correct Color but Wrong Position: #{w_dots}"
    false
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
