require './lib/mastermind'
require 'minitest/autorun'
require 'minitest/pride'

class Mastermind_Test < Minitest::Test

  def test_if_exists
    game = Mastermind.new
    assert_instance_of Mastermind, game
  end

  def test_count_colors_method
    game = Mastermind.new
    assert_equal true, game.count_colors(["r", "g", "b", "y"]) == [1, 1, 1, 1]
  end

  def test_check_correct_colors_method
    game = Mastermind.new
    assert_equal true,
      game.check_correct_colors([1, 1, 2, 0], [1, 1, 1, 1]) == 3
  end

  def test_cheat
    game = Mastermind.new
    assert_equal true,
      game.cheat == game.instance_variable_get(:@colors)
  end


end
