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
    code_breaker()
  end

  def new_game
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
            randomizer()
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
    
  end

  def code_breaker
    guess = 1
    while guess < 11
        code_guess = []
        print @@code
        puts ''
        puts ''
        puts "Turn ##{guess}: Type in four numbers (1-6) to guess code, or 'q' to quit game."
        type_code = gets.chomp
        if type_code == 'q'
          exit
        end
        code_guess = type_code.to_s.split('').map(&:to_i)
        guess += 1
        checker(code_guess)
    end
  end

  def checker(code)
    if @@code == code
        puts "\nYou broke the code! Congratulations, you win!"
        puts "Would you like to play a new game? 'y' for yes, press any key if no"
        answer = gets.chomp

        if answer == 'y'
          new_game()
        else
            exit
        end
    end
    print "#{code[0]} #{code[1]} #{code[2]} #{code[3]}"
    print "    Clues: "

    @@code.each_with_index do |z, ind|
      if z == code[ind]
        print clue_colors('?')
      elsif code.include?(z)
        print clue_colors('*')
      end
    end
  end


end

play = Mastermind.new
play.start()