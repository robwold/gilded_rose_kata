require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative './gilded_rose'

class GildedRoseTest < MiniTest::Test
  # This is not a good test, but checks our basic setup
  def test_update_quality
    item = Item.new("+5 Dexterity Vest", 10, 20)
    update_quality [item]
    assert_equal item.quality, 19
  end
end