# Model to represent user in MasterMind Project
class User
  include Evaluating
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
