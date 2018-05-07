require 'pry'
#mastermind.rb
#puts "\e" how to clear console
#potentially cross off element from colors array (new copy array with deleted values)
#pass colors as an array because mutable
#assignment operator is non-mutable!
#shovel operator and pop are mutable

class Mastermind

    def initialize()
      @colors = randomize_colors
      # p @colors[:"1"]
    end

    def start
      print_game_title
      print_ask_to_play
      answer = ask_to_play
      if answer == "p"
        while print_correctness(play(get_play)) == false
          print_correctness(play(get_play))
        end
      elsif answer == "i"
        print_instructions
      elsif answer == "q"
        quit_game
      end
    end

    def ask_to_play

      user_input = ""

      while user_input != "q".downcase #downcase accounts for capitals

        user_input = gets.chomp

        if user_input == "p".downcase
          return "p"
        elsif user_input == "i".downcase
          return "i"
        elsif user_input == "q".downcase
          return "q"
        else
          puts "Invalid input. Please try again: "
        end #end if
      end #end while
  end #end ask_to_play

  def play(user_colors)

    correct_indexes = 0
    correct_colors = 0
    found = false
    index_counter = 0
    color_counter = 0
    counter = 0
    modded_user_colors = user_colors.dup
    p modded_user_colors

    # @colors = hash of correct colors ex: ["g", "b", "y", "r"]
    # returns the correct number of indexes guessed
    @colors.each do |key, value|

      # if first value of user_colors = first value of comp generated colors
      if user_colors[index_counter].to_s == "#{value}".to_s.gsub("^0-9", "") && index_counter < 5
        correct_indexes += 1
      elsif user_colors == "c".downcase
        cheat
      end
      index_counter += 1

      # if the value of the hash colors in this iteration is equal to
      4.times do
        # if there is a matching user_color in the modded hash, delete it
        if user_colors[color_counter].to_s == "#{value}".to_s.gsub("^0-9", "")
          correct_colors += 1
        end
        color_counter += 1
      end
    end
    index_counter = 0
    color_counter = 0
    return [correct_colors, correct_indexes, user_colors]

  end # end play


  def print_correctness(arr)
    puts `clear`
    print arr[2].flatten.to_s.gsub("^0-9", "") + " has " \
      + arr[0].to_s + " correct colors with " + arr[1].to_s\
      + " in the correct position(s)\n"
    if arr[0] = 4 && arr[1] == 4
      return true
    end
    return false
  end

  def cheat
    puts "Answer: " + @colors.to_s
  end

  def randomize_colors
    counter = 1
    rgby = ["r", "g", "b", "y"]
    color_hash = {}
    4.times do
      color_hash.store(:"#{counter}", rgby.sample)
      counter += 1
    end
    return color_hash
    #returns a hash of colors
  end

  def print_prompt
    puts `clear` #clears the terminal
    prompt = "I have generated a beginner sequence with four elements made up"\
      "of (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to"\
      "end the game." + "\n" + "What's your guess? "
  end

  def print_instructions
    puts `clear`
    print instructions =
      "The idea of the game is for one player (the code-breaker) to guess the "\
      "secret code chosen by the computer. The code is a sequence of 4 "\
      "colored pegs chosen from six colors available. The code-breaker makes "\
      "a series of pattern guesses - after each guess the code-maker gives "\
      "feedback in the form of 2 numbers, the number of pegs that are of the "\
      "right color and in the correct position, and the number of pegs that "\
      "are of the correct color but not in the correct position - these "\
      "numbers are usually represented by small black and white pegs."

      puts "\nPress the return key to return to home screen: "
      user_input = gets.chomp
      start

  end

  def print_ask_to_play
    puts `clear`
    print "Would you like to (p)lay, read the (i)nstructions, or (q)uit? "
  end

  def print_game_title
    game_title = "Welcome to M@Š†€®m¡ñÐ"
    puts game_title.dump
  end

  def get_play
    puts `clear`
    puts "Enter a color sequence in the format: rgby"
    print "> "
    user_colors = gets.chomp
    user_colors = user_colors.chars
  end

  def quit_game
    puts "Goodbye."
    sleep(1) #so that the user can see "Goodbye."
    exit
  end

end #end mastermind.rb
