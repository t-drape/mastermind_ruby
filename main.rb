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
#     - [ ] Update PlayGame
#         - [ ] Create true/false boolean value is_guesser
#         - [ ] Ask user “Do you want to be the guesser? [Y/N] ”
#         - [ ] Get user input
#             - [ ] If Y,
#                 - [ ] PlayGame as normal
#             - [ ] If N,
#                 - [ ] Ask user for color code
#                 - [ ] If any color not in ACCEPTABLE_COLORS, re ask until code is acceptable
#                 - [ ]  PlayGame with updated logic, see Step 3.
#             - [ ] Else re-ask, with message, “Invalid. Do you want to be the guesser? [Y/N] ”

# Step 3:
# “Build it out so that the computer will guess if you decide to choose your own secret color.”
#     - [ ] Model Mastermind strategy
#     - [ ] After each guess,
#     - [ ] Learn from last guesses,
#     - [ ] Make more educated guess
#     - [ ] Make computer beatable, but not easy (medium)
#     - [ ] Create game logic
#     - [ ] Play 12 Rounds as normal

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

def double_matches_delete(delete_indexes, guess, computer_color_code)
  delete_indexes = delete_indexes.reverse
  delete_indexes.each do |index|
    guess.delete_at(index)
    computer_color_code.delete_at(index)
  end
  [guess, computer_color_code]
end

def double_matches(guess, computer_color_code)
  indexes = []
  guess.each_with_index do |color, index|
    next unless color == computer_color_code[index]

    indexes << index
  end
  indexes
end

def compare_codes(user_guess, random_color_code, b_dots, w_dots)
  # Try removing elements from array once a match is hit
  # Work on clone to not permanently remove elements from original

  guess = user_guess.clone
  computer_color_code = random_color_code.clone

  delete_indexes = double_matches(guess, computer_color_code)

  b_dots += delete_indexes.length

  guess, computer_color_code = double_matches_delete(delete_indexes, guess, computer_color_code)

  guess.each do |color|
    delete_index = nil
    computer_color_code.each_with_index do |computer_color, computer_index|
      next unless color == computer_color

      w_dots += 1
      delete_index = computer_index
      break
    end
    computer_color_code.delete_at(delete_index) if delete_index
  end

  [b_dots, w_dots]
end

def equality_check(guess, computer_color_code)
  return unless guess == computer_color_code

  p "Winner"
  true
end

def evaluate_round(guess, computer_color_code, b_dots, w_dots)
  return true if equality_check(guess, computer_color_code)

  if computer_color_code.any? { |element| guess.include?(element) }
    b_dots, w_dots = compare_codes(guess, computer_color_code, b_dots, w_dots)
  end
  p "Correct Color and Position: #{b_dots}"
  p "Correct Color but Wrong Position: #{w_dots}"
  false
end

def play_round(computer_color_code)
  w_dots = 0
  b_dots = 0

  redo_needed = false

  guess = user_guess

  guess = user_guess unless guess.length == 4

  guess.each do |color|
    redo_needed = true unless ACCEPTABLE_COLORS.include?(color)
  end
  guess = user_guess if redo_needed

  evaluate_round(guess, computer_color_code, b_dots, w_dots)
end

def play_game
  computer_color_code = get_color_code(ACCEPTABLE_COLORS)
  end_game = false
  12.times do
    end_game = play_round(computer_color_code)
    break if end_game
  end
  p computer_color_code
end

play_game
