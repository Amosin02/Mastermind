# frozen_string_literal: true

require './color.rb'
include Color

# repos/ruby/Mastermind/play.rb
class Mastermind
  def initialize 
    @@code = []
    @@computer_code = []
    @@guess = 1
    @@clue = []
    @@possible_numbers = []
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
        initialize()
        if choice == '1'
            code_maker()
            break
        elsif choice == '2'
            randomizer()
            code_breaker()
            break
        end
    end
  end

  def path1() # '?' (1 correct number in the correct location)
    #comp_checker(@@computer_code)
    counter = @@clue.count("*")
    freeze = @@clue.count("?")
    if counter == 2 && freeze == 2
      n = 0
      @@clue.map.with_index {|f,i| f == "?" ? n = i : i}
      x = @@computer_code[n]
      @@computer_code = [x,x,x,x]
      puts "\n#{number_colors("#{@@computer_code[0]}")} #{number_colors("#{@@computer_code[1]}")} #{number_colors("#{@@computer_code[2]}")} #{number_colors("#{@@computer_code[3]}")} is the code"
      comp_checker(@@computer_code)
    elsif counter == 4
      @@computer_code[0], @@computer_code[1] = @@computer_code[1], @@computer_code[0]
    end
    
  end

  def path2(counter,freeze) # '*' (1 correct number in the wrong location)
    #puts "Partial: #{counter} Right place: #{freeze}"
    if counter == 2
      @@computer_code[1] += 2
      @@computer_code[3] += 1
    elsif counter == 1
      @@computer_code[2] += 1
      @@computer_code[3] += 1
    elsif counter == 3
      @@computer_code[3] += 1
    elsif freeze == 2
      @@computer_code[2] = rand(1..6)
      @@computer_code[3] = rand(1..6)
    elsif  freeze == 1
      @@computer_code[2] = rand(1..6)
      @@computer_code[3] = rand(1..6)
      @@computer_code[1] = rand(1..6)
    end
    @@computer_code.map! { |n| n > 6 ? n-6 : n}
    #print @@computer_code
  end 

  def code_maker
    now = 0

    while true
      puts "\nPlease enter a 4-digit (1-6) 'master code' for the computer to break"
      code_input = gets.chomp
      @@code = code_input.chars.map(&:to_i)

      if @@code.all? { |a| a.between?(1, 6) } && @@code.length == 4
        num1 = 1
        num2 = 2
        @@computer_code = [num1,num1,num2,num2] # get the clues so that you can arrange
        # things properly and add random numbers properly.

        while now < 10 # issue for now is pag walang '*'
          print_code(@@computer_code)
          if @@clue.length() == 4
            path1()
          else 
            if @@clue.include?("*") || @@clue.include?("?") # '*' (1 correct number in the wrong location)
              counter = @@clue.count("*")
              freeze = @@clue.count("?")
              path2(counter,freeze)
            else 
              @@computer_code.map! { |n| n+2 }
            end
          end
          
          #puts "#{@@clue}"
          now += 1
          @@clue = [] # Use the clue to to either generate new numbers or move the numbers
        end
        comp_checker(@@computer_code)

      else 
        print "Error: "
      end
    end

  end

  def code_breaker
    while true
      code_guess = []
      #print @@code #remove this when it's done
      puts "\n"
      puts "Turn ##{@@guess}: Type in four numbers (1-6) to guess code, or 'q' to quit game."
      type_code = gets.chomp
      code_guess = type_code.to_s.split('').map(&:to_i)
      if type_code == 'q'
        exit
      elsif code_guess.all? { |a| a.between?(1, 6) }
        checker(code_guess)
        max?(@@guess)
        @@guess += 1
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
        print "\n#{number_colors("#{code[0]}")} #{number_colors("#{code[1]}")} #{number_colors("#{code[2]}")} #{number_colors("#{code[3]}")} "
        puts "You broke the code! Congratulations, you win!"
        new_game?()
    end
    print_code(code)
  end

  def comp_checker(code)
    if @@code == code
      puts "\nYou lost! The computer won!"
      new_game?()
    else
      puts "\nYou won! The computer can't guess your code"
      new_game?()
    end
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

  def print_code(code)
    print "\n#{number_colors("#{code[0]}")} #{number_colors("#{code[1]}")} #{number_colors("#{code[2]}")} #{number_colors("#{code[3]}")} "
    print "    Clues: "

    @@code.each_with_index do |z, ind|
      if z == code[ind]
        @@clue << '?'
        print clue_colors('?')
      elsif code.include?(z)
        @@clue << '*'
        print clue_colors('*')
      end
    end

    puts ''
  end
end

play = Mastermind.new
play.start()