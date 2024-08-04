# frozen_string_literal: true

# MasterMind Pseudocode

# Step 1:
# “Build the game assuming the computer randomly selects the secret colors, and the human player must guess them.
#  Remember that you need to give the proper feedback 	on  how good the guess was each turn!”

#     - [ ] Create PlayGame function/class
#         - [x] Set ACCEPTABLE_COLORS to six colors, (blue, red, orange, yellow, purple, green)
#         - [x] Let computer generate random four color code, (blue, red, orange, yellow, purple, green)
#         - [ ] Define PlayGame to PlayRound 12 times
#             - [ ] If winner, exit loop, print congratulatory message
#             - [ ] Else, continue until 12, then print loser message
#         - [ ] PlayRound
#             - [ ] Set black_dot_variable to 0
#             - [ ] Set white_dot_variable to 0
#             - [ ] Get User Guess
#             - [ ] Compare User Guess to random color code
#             - [ ] If equal, declare winner
#             - [ ] Else,
#                 - [ ] If any color from guess in color code,
#                     - [ ] For each color in user guess,
#                         - [ ] If guess is correct color and position,
#                             - [ ] Increase black_dot by one
#                         - [ ] Else if guess is correct color but wrong position,
#                             - [ ] Increase white_dot by one
#                         - [ ] Else do nothing
#                 - [ ] Else, continue loop
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

# def compare_codes(guess, computer_color_code, black_dots_correct_color_correct_position,
#                   white_dots_correct_color_wrong_position)
#   guess.each_with_index do |guess_color, guess_index|
#     computer_color_code.each_with_index do |computer_color, computer_color_index|
#       if guess_color == computer_color && guess_index == computer_color_index
#         black_dots_correct_color_correct_position += 1
#         break
#       elsif guess_color == computer_color && guess_index != computer_color_index
#         white_dots_correct_color_wrong_position += 1
#         break
#       end
#     end
#   end
#   [black_dots_correct_color_correct_position, white_dots_correct_color_wrong_position]
# end
#

def compare_codes(guess, computer_color_code, black_dots, white_dots)
  new_hash = {}
  guess.each_with_index do |color, index|
    if computer_color_code[index] == color
      black_dots += 1
      new_hash[[index, index]] = 1
      next
    end
    computer_color_code.each_with_index do |computer_color, computer_index|
      next unless color == computer_color && index != computer_index

      if new_hash[[index, computer_index]]
        new_hash[[index, computer_index]] += 1
      else
        new_hash[[index, computer_index]] = 1
      end
    end
  end
  x = new_hash.select { |key, _value| key[0] == key[1] }
  kf = x.keys.flatten
  y = new_hash.reject { |key, _value| kf.include?(key[1]) }
  p y
  ununiq = y.map { |key, value| key[1] }
  unique = ununiq.uniq
  white_dots = unique.length
  [black_dots, white_dots]
end

def evaluate_round(guess, computer_color_code, black_dots_correct_color_correct_position,
                   white_dots_correct_color_wrong_position)
  if guess == computer_color_code
    p "Winner"
  elsif computer_color_code.any? { |element| guess.include?(element) }
    black_dots_correct_color_correct_position, white_dots_correct_color_wrong_position = compare_codes(guess, computer_color_code, black_dots_correct_color_correct_position,
                                                                                                       white_dots_correct_color_wrong_position)
    p "Correct Color and Position: #{black_dots_correct_color_correct_position}"
    p "Correct Color but Wrong Position: #{white_dots_correct_color_wrong_position}"
  else
    p "Correct Color and Position: #{black_dots_correct_color_correct_position}"
    p "Correct Color but Wrong Position: #{white_dots_correct_color_wrong_position}"
  end
end

def play_round(computer_color_code)
  white_dots_correct_color_wrong_position = 0
  black_dots_correct_color_correct_position = 0

  guess = user_guess

  guess = user_guess unless guess.length == 4
  guess.each do |color|
    guess = user_guess unless ACCEPTABLE_COLORS.include?(color)
  end

  evaluate_round(guess, computer_color_code, black_dots_correct_color_correct_position,
                 white_dots_correct_color_wrong_position)
end

computer_color_code = get_color_code(ACCEPTABLE_COLORS)

computer_color_code = %w[red blue red orange]
def play_game(computer_color_code)
  12.times { play_round(computer_color_code) }
end

play_game(computer_color_code)
