# frozen_string_literal: true

require_relative "element_classes/computer"
require_relative "element_classes/user"

# A single class to hold all gameplay for MasterMind Project!
class Game
  ACCEPTABLE_COLORS = %w[blue red orange yellow purple green].freeze
  def initialize
    puts "What is Your Name? "
    @user = User.new(gets.chomp, ACCEPTABLE_COLORS)
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
      comp = Computer.new(@user.choice, ACCEPTABLE_COLORS)
      comp.computer_guessing_user_code(@user.code)
      @user.is_winner = !comp.is_winner
      @user.ending_message
    else
      @user.user_guessing_computer_code
    end
  end
end
