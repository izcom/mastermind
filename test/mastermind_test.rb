require 'minitest/autorun'
require 'minitest/pride'
require './lib/mastermind'

class Mastermind_Test < Minitest::Test

  #working
  def test_it_exists
    game = Mastermind.new
    assert_instance_of Mastermind, game
  end

  def test_cheat
    game = Mastermind.new
    assert_equal true, cheat
  end

end
