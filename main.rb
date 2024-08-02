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
