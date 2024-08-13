# frozen_string_literal: true

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
