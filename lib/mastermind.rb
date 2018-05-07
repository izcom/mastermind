require 'pry'
require 'io/console'

class Mastermind

  def initialize
    @colors = randomize_colors
    @guesses = 0
    @start_time
    @end_time
  end

  # returns an array of random colors to @colors
  def randomize_colors
    colors = ["r", "g", "b", "y"]
    random_colors = []
    4.times do
      random_colors << colors.sample
    end
    return random_colors
  end

  def start
    choice = ""
    print_game_title
    choice = get_user_play_choice
    if choice == "p".downcase # allows for if the user inputs a capital
      @start_time = Time.now.strftime("%M:%S") # hours and minutes
      loop do
      @guesses += 1
      play
      end
    elsif choice == "i".downcase
      print_instructions
    elsif choice == "q".downcase
      quit_game
    else
      puts "Error."
    end
  end

  def get_user_play_choice
    user_choice = gets.chomp
  end

  def get_user_guess
    valid_guess = false
    while valid_guess == false
      user_guess = gets.chomp.chars
      if user_guess[0] == "q"
        quit_game
      elsif user_guess[0] == "c"
        cheat
        puts "> "
      elsif user_guess.length > 4 || user_guess.length < 4
        puts "Invalid guess. Please guess again: "
      elsif user_guess.include?(!"rgby")
        puts "Invalid guess. Please guess again: "
      else
        valid_guess = true
      end
    end
    return user_guess
  end

  def play
    print_ask_for_guess
    user_guess = get_user_guess
    index_total = check_correct_indexes(user_guess)

    user_color_arr = count_colors(user_guess)
    comp_color_arr = count_colors(@colors)
    color_total = check_correct_colors(user_color_arr, comp_color_arr)
    results = [color_total, index_total, user_guess]

    if color_total == 4 && index_total == 4
      @end_time = Time.now.strftime("%M:%S")
      time_arr = calc_time_taken
      print_win(time_arr)
      choice = get_user_play_choice
      if choice == "p" || choice == "play"
        @start_time = Time.now.strftime("%M:%S")
        start
      elsif choice == "q" || choice == "quit"
        quit_game
      end
    end
    print_correct(results)
  end

  def count_colors(color_array)
    r = 0
    y = 0
    g = 0
    b = 0
    results = []
    color_array.each do |color|
      if color == "r"
        r += 1
      elsif color == "y"
        y += 1
      elsif color == "g"
        g += 1
      elsif color == "b"
        b += 1
      else
        puts "Error."
      end
    end
    results += [r, y, g, b]
    # returns array of correct colors in rygb order
  end

  # user/comp looks like [1, 1, 2, 0]
  def check_correct_colors(user, comp)
    correct_colors = 0

    4.times do |counter|
      if user[counter] > 0 && comp[counter] > 0
        if user[counter] > comp[counter]
          correct_colors += comp[counter]
        elsif user[counter] < comp[counter]
          correct_colors += user[counter]
        elsif user[counter] == comp[counter]
          correct_colors += user[counter]
        end
      end
      # [1, 1, 1, 0] => user[counter]
      # [0, 2, 1, 0] => comp[counter]
    end
    return correct_colors
  end

  # passes in an array of user guess
  def check_correct_indexes(user_guess)
    counter = 0
    correct_indexes = 0
    4.times do
      if user_guess[counter] == @colors[counter] # @colors[counter] working as expected
        correct_indexes += 1
      end
      counter += 1
    end
    return correct_indexes
  end

  def cheat
    puts "Answer is: " + @colors.to_s.gsub("^0-9", "")
  end

  def print_game_title
    puts `clear`
    print "Welcome to M@Š†€®m¡ñÐ"
    print "\n"
    print "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n"
    print "> "
  end

  def print_instructions
    puts `clear`
    print instructions =
      "The idea of the game is for one player (the code-breaker) to guess the "\
      "secret code chosen by the computer. The code is a sequence of 4 "\
      "colored pegs chosen from six colors available.\nThe code-breaker makes "\
      "a series of pattern guesses - after each guess the code-maker gives "\
      "feedback in the form of 2 numbers, the number of pegs that are of the "\
      "right color and in\nthe correct position, and the number of pegs that "\
      "are of the correct color but not in the correct position - these "\
      "numbers are usually represented by small black and white pegs."
      print "\nPress return to go back to home screen."
      input = gets.chomp
      start
  end

  def print_ask_for_guess
    puts `clear`
    print "I have generated a beginner sequence with four elements made up "\
    "of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end "\
    "the game. What's your guess?\n"
    print "> "
  end

  def print_correct(results)
    correct_colors = results[0]
    correct_indexes = results[1]
    user_guess = results[2].flatten.to_s.gsub("^0-9", "")
    print user_guess.to_s + " has " + correct_colors.to_s + " of the correct "\
      "colors with " + correct_indexes.to_s + " in the correct position(s)\n"
    print "\nYou've taken " + @guesses.to_s + " guess(es)."
    puts "Press enter to guess again"
    gets.chomp
  end

  def print_win(time_arr)
    puts `clear`
    puts "Congratulations. You guessed the sequence "\
      + @colors.to_s.gsub("^0-9", "") + " in " + @guesses.to_s + " guess(es) "\
      "over " + time_arr[0].abs.to_s + " minutes, " + time_arr[1].abs.to_s + ""\
      " seconds.\n"
    puts "Do you want to (p)lay again or (q)uit? "
  end

  def calc_time_taken
    # "46:24" "48:17"
    minutes = @start_time[0..1].to_i - @end_time[0..1].to_i
    seconds = @start_time[3..4].to_i - @end_time[3..4].to_i
    return [minutes, seconds]
  end

  def quit_game
    puts "Goodbye."
    exit
  end

end #end Mastermind
