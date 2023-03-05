# frozen_string_literal: true

require './color.rb'
include Color

# repos/ruby/Mastermind/play.rb
class Mastermind
  def initialize 
    @@code = []
  end

  def start
    instruction()
    player_selection()
  end

  def instruction
    puts "#{clue_colors('?')}This clue means you have 1 correct number in the correct location."
    puts "#{clue_colors('*')}This clue means you have 1 correct number, but in the wrong location. "
  end

  def randomizer
    x = 0
    while x < 4
        @@code << rand(1..6)
        x += 1
    end
  end

  def player_selection 
    puts "\nWould you like to be the code MAKER or code BREAKER?"
    while true
        puts ''
        puts "Press '1' to be the code MAKER"
        puts "Press '2' to be the code BREAKER"
        choice = gets.chomp
        if choice == '1'
            initialize()
            code_maker()
            break
        elsif choice == '2'
            initialize()
            randomizer()
            code_breaker()
            break
        end
    end
  end

  def code_maker
    while true
      computer_code = []
      puts "Please enter a 4-digit (1-6) 'master code' for the computer to break"
      code_input = gets.chomp
      @@code = code_input.chars.map(&:to_i)
      code_array = code_input.chars.map(&:to_i)
      if code_array.all? { |a| a.between?(1, 6) }
        num1 = 1
        num2 = 2
        computer_code = [num1,num1,num2,num2]
        print_code(computer_code)
        break
      else 
        print "Error: "
      end
    end
  end

  def print_code(code)
    print "#{number_colors("#{code[0]}")} #{number_colors("#{code[1]}")} #{number_colors("#{code[2]}")} #{number_colors("#{code[3]}")} "
    print "    Clues: "

    @@code.each_with_index do |z, ind|
      if z == code[ind]
        print clue_colors('?')
      elsif code.include?(z)
        print clue_colors('*')
      end
    end

    puts ''
  end

  def code_breaker
    guess = 1
    while true
      code_guess = []
      print @@code
      puts "\n\n"
      puts "Turn ##{guess}: Type in four numbers (1-6) to guess code, or 'q' to quit game."
      type_code = gets.chomp
      code_guess = type_code.to_s.split('').map(&:to_i)
      if type_code == 'q'
        exit
      elsif code_guess.all? { |a| a.between?(1, 6) }
        checker(code_guess)
        max?(guess)
        guess += 1
      else 
        print "Error: "
      end
    end
   end

  def max?(guess)
    if guess == 10
      puts "You Lost! You reached the maximum tries"
      new_game?()
      exit
    end
  end

  def checker(code)
    if @@code == code
        puts "\nYou broke the code! Congratulations, you win!"
        new_game?()
    end
    print_code(code)
  end

  def new_game?()
    puts "Would you like to play a new game? 'y' for yes, press any key if no"
      answer = gets.chomp
      if answer == 'y'
        player_selection()
      else
          exit
      end
  end
end

play = Mastermind.new
play.start()