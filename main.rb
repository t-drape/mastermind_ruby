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

white_dots_correct_color_wrong_position = 0
black_dots_correct_color_correct_position = 0

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

computer_color_code = get_color_code(ACCEPTABLE_COLORS)

guess = user_guess

guess = user_guess unless guess.length == 4
guess.each do |color|
  guess = user_guess unless ACCEPTABLE_COLORS.include?(color)
end

def compare_colors(guess, computer_color_code, black_dots_correct_color_correct_position,
                   white_dots_correct_color_wrong_position)
  guess.each_with_index do |guess_color, guess_index|
    computer_color_code.each_with_index do |computer_color, computer_color_index|
      if guess_color == computer_color && guess_index == computer_color_index
        black_dots_correct_color_correct_position += 1
        break
      elsif guess_color == computer_color && guess_index != computer_color_index
        white_dots_correct_color_wrong_position += 1
        break
      end
    end
  end
  [black_dots_correct_color_correct_position, white_dots_correct_color_wrong_position]
end

def evaluate_round(guess, computer_color_code, black_dots_correct_color_correct_position,
                   white_dots_correct_color_wrong_position)
  if guess == computer_color_code
    p "Winner"
  elsif computer_color_code.any? { |element| guess.include?(element) }
    b_dots, w_dots = compare_colors(guess, computer_color_code, black_dots_correct_color_correct_position,
                                    white_dots_correct_color_wrong_position)
    p "Correct Color and Position: #{b_dots}"
    p "Correct Color but Wrong Position: #{w_dots}"
  else
    p "loser"
  end
end

evaluate_round(guess, computer_color_code, black_dots_correct_color_correct_position,
               white_dots_correct_color_wrong_position)

def play_round
end
