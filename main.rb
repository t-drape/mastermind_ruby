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

require_relative "lib/game"

MASTERMIND = Game.new
MASTERMIND.play_game
