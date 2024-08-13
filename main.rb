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

def user_guess
  guess = []
  puts "What's your four-color guess? (ex: blue, blue, blue, blue)"
  puts "Available Colors: blue, red, orange, yellow, purple, green "
  4.times do |time|
    puts "Color #{time + 1}: "
    guess << gets.chomp
  end
  guess
end

def check_user_input(code)
  code = user_code unless code.length == 4

  redo_needed = false

  code.each do |color|
    redo_needed = true unless ACCEPTABLE_COLORS.include?(color)
  end
  code = user_code if redo_needed

  code
end

def user_code
  code = []
  puts "What's your four-color code? (ex: blue, blue, blue, blue)"
  puts "Available Colors: blue, red, orange, yellow, purple, green "
  4.times do |time|
    puts "Color #{time + 1}: "
    code << gets.chomp
  end
  check_user_input(code)
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

def evaluate_round(guess, color_code, b_dots, w_dots)
  return true if guess == color_code

  if color_code.any? { |element| guess.include?(element) }
    b_dots, w_dots = compare_codes(guess, color_code, b_dots, w_dots)
  end
  p "Correct Color and Position: #{b_dots}"
  p "Correct Color but Wrong Position: #{w_dots}"
  false
end

def computer_evaluate_round(guess, color_code, b_dots, w_dots)
  if color_code.any? { |element| guess.include?(element) }
    b_dots, w_dots = compare_codes(guess, color_code, b_dots, w_dots)
  end
  [b_dots, w_dots]
end

def play_round(color_code)
  w_dots = 0
  b_dots = 0

  redo_needed = false

  guess = user_guess

  guess = user_guess unless guess.length == 4

  guess.each do |color|
    redo_needed = true unless ACCEPTABLE_COLORS.include?(color)
  end
  guess = user_guess if redo_needed

  evaluate_round(guess, color_code, b_dots, w_dots)
end

def play_computer_guessing_round(computer_guess, user_code, cca)
  b_dots = 0
  w_dots = 0
  bd, wd = computer_evaluate_round(computer_guess, user_code, b_dots, w_dots)
  bd.times do
    cca << computer_guess[0]
  end
  bd == 4
end

def user_pick
  puts "Do you want to create the code? [Y/N] "
  user_choice = gets.chomp
  user_pick unless %w[Y N].include?(user_choice)

  user_choice == "N"
end

def user_guessing_computer_code
  color_code = get_color_code(ACCEPTABLE_COLORS)
  end_game = false
  12.times do |time|
    puts "---Attempt No: #{time + 1}---"
    end_game = play_round(color_code)
    break if end_game
  end
  p color_code
  ending_message(end_game, true)
  # puts "You Guessed the Computer's Code!" if end_game
  # puts "You did not Guess the Computer's Code!" unless end_game
end

def ending_message(won_game, guessing)
  message = if guessing
              won_game ? "You Guessed the Computer's Code!" : "You did not Guess the Computer's Code!"
            else
              won_game ? "The computer guessed your code!" : "You beat the computer!"
            end
  puts message
end

# MAYBE SWITCH TIMES LOOP TO EACH WITH INDEX
# NEED GLOBAL VARIABLE FOR ROUNDS!!!!!!!

def single_color_computer_guess(code, cca)
  ACCEPTABLE_COLORS.length.times do |time|
    puts "---Attempt No: #{time + 1}---"
    guess = Array.new(4, ACCEPTABLE_COLORS[time])
    p guess
    end_game = play_computer_guessing_round(guess, code, cca)
    return cca if end_game
    next unless cca.length == 4

    return cca
  end
end

def shuffled_guesses(code, cca)
  6.times do |time|
    p "---Attempt No: #{time + 1}---"
    cca = cca.shuffle
    p cca
    return true if cca == code
  end
  false
end

def computer_guessing_user_code
  cca = []
  code = user_code
  # 6.times do |time|
  #   puts "---Attempt No: #{time + 1}---"
  #   guess = Array.new(4, ACCEPTABLE_COLORS[time])
  #   p guess
  #   end_game = play_computer_guessing_round(guess, code, cca)
  #   break if end_game

  #   next unless cca.length == 4

  #   future_times = 11 - time
  #   break
  # end
  cca = single_color_computer_guess(code, cca)
  end_game = cca == code ? true : shuffled_guesses(code, cca)
  # 6.times do |time|
  #   p "---Attempt No: #{(12 - (future_times - time)) + 1}---"
  #   cca = cca.shuffle
  #   p cca
  #   if cca == code
  #     end_game = true
  #     break
  #   end
  # end
  #
  ending_message(end_game, false)
  # puts "The computer guessed your code!" if end_game
  # puts "You beat the computer!" unless end_game
end

def play_game
  if user_pick
    puts "You are guessing the computer's code!"
    user_guessing_computer_code

  else
    puts "The computer is guessing your code!"
    computer_guessing_user_code
  end
end

play_game
