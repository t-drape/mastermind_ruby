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
#
# Try removing elements from array once a match is hit

def compare_codes(my_guess, the_computer_color_code)
  # Try removing elements from array once a match is hit
  bd = 0
  wd = 0

  guess = my_guess.clone
  computer_color_code = the_computer_color_code.clone

  delete_indexes = []

  guess.each_with_index do |color, index|
    next unless color == computer_color_code[index]

    bd += 1
    delete_indexes << index
  end

  delete_indexes = delete_indexes.reverse
  delete_indexes.each do |index|
    guess.delete_at(index)
    computer_color_code.delete_at(index)
  end

  guess.each do |color|
    delete_index = nil
    computer_color_code.each_with_index do |computer_color, computer_index|
      next unless color == computer_color

      wd += 1
      delete_index = computer_index
      break
    end
    computer_color_code.delete_at(delete_index) if delete_index
  end

  [bd, wd]
end

# new_new_guess = guess.clone
# new_new_code = computer_color_code.clone

# new_guess.each_with_index do |color, index|
#   next unless new_code.include?(color)

#   wd += 1
#   new_new_guess.delete_at(index)
#   y = new_new_code.find_index(color)
#   new_new_code.delete_at(y)
# end

# new_guess.each do |color|
#   new_code.each do |computer_color|
#     next unless color == computer_color

#     wd += 1
#     p "---Guess----"
#     p new_guess
#     x = new_guess.find_index(color)
#     new_guess.delete_at(x)
#     p new_guess
#     p "----Code-----"
#     p new_code
#     y = new_code.find_index(computer_color)
#     new_code.delete_at(y)
#     p new_code
#     break
#   end
# end

# guess.each_with_index do |color, index|
#   if computer_color_code[index] == color
#     black_dots += 1
#     new_hash[[index, index]] = 1
#     next
#   end
#   computer_color_code.each_with_index do |computer_color, computer_index|
#     next unless color == computer_color && index != computer_index

#     if new_hash[[index, computer_index]]
#       new_hash[[index, computer_index]] += 1
#     else
#       new_hash[[index, computer_index]] = 1
#     end
#     break
#   end
# end
# x = new_hash.select { |key, _value| key[0] == key[1] }
# kf = x.keys.flatten
# y = new_hash.reject { |key, _value| kf.include?(key[1]) }
# zero_keys = y.keys.map { |key| key[0] }
# m = y.each_key.select { |key| zero_keys.count(key[0]) > 1 }
# nm = m.map { |val| val[1] }
# p nm.uniq
# ununiq = y.map { |key, value| key[1] }
# unique = ununiq.uniq
# p ununiq.length
# [black_dots, ununiq.uniq.length]

def evaluate_round(guess, computer_color_code, bdots,
                   wdots)
  if guess == computer_color_code
    p "Winner"
    true
  elsif computer_color_code.any? { |element| guess.include?(element) }
    bdots, wdots = compare_codes(guess, computer_color_code)
    p "Correct Color and Position: #{bdots}"
    p "Correct Color but Wrong Position: #{wdots}"
    false
  else
    p "Correct Color and Position: #{bdots}"
    p "Correct Color but Wrong Position: #{wdots}"
    false
  end
end

def play_round(computer_color_code)
  white_dots_correct_color_wrong_position = 0
  black_dots_correct_color_correct_position = 0

  guess = user_guess

  guess = user_guess unless guess.length == 4

  redo_needed = false
  guess.each do |color|
    redo_needed = true unless ACCEPTABLE_COLORS.include?(color)
  end
  guess = user_guess if redo_needed

  evaluate_round(guess, computer_color_code, black_dots_correct_color_correct_position,
                 white_dots_correct_color_wrong_position)
end

computer_color_code = get_color_code(ACCEPTABLE_COLORS)

def play_game(computer_color_code)
  p computer_color_code
  end_game = false
  12.times do
    end_game = play_round(computer_color_code)
    break if end_game
  end
end

play_game(computer_color_code)
