require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative './gilded_rose'

class GildedRoseTest < MiniTest::Test

  def make_and_update(name:, sell_in:, quality:)
    item = Item.new(name, sell_in, quality)
    GildedRose.new.update_quality [item]
    item
  end

  # This is not a good test, but checks our basic setup
  def test_generic_item_quality
    item = make_and_update(name: "+5 Dexterity Vest", sell_in: 10, quality: 20)
    assert_equal 19, item.quality
  end

  def test_generic_item_sell_in
    item = make_and_update(name: "+5 Dexterity Vest", sell_in: 10, quality: 20)
    assert_equal 9, item.sell_in
  end

  # - Once the sell by date has passed, Quality degrades twice as fast
  def test_expired_products_degrade_faster
    item = make_and_update(name: "+5 Dexterity Vest", sell_in: 0, quality: 20)
    assert_equal 18, item.quality
  end

  # - The Quality of an item is never negative
  def test_quality_is_never_negative
    item = make_and_update(name: "+5 Dexterity Vest", sell_in: 0, quality: 1)
    assert_equal 0, item.quality
  end

  # - "Aged Brie" actually increases in Quality the older it gets
  def test_aged_brie_increases_in_quality
    item = make_and_update(name: "Aged Brie", sell_in: 10, quality: 20)
    assert_equal 21, item.quality
  end

  def test_expired_aged_brie_improves_faster
    item = make_and_update(name: "Aged Brie", sell_in: 0, quality: 20)
    assert_equal 22, item.quality
  end

  # - The Quality of an item is never more than 50
  def test_aged_brie_quality_never_exceeds_max
    item = make_and_update(name: "Aged Brie", sell_in: 10, quality: 50)
    assert_equal 50, item.quality
  end

  # "Sulfuras", being a legendary item, never has to be sold or
  #  decreases in Quality
  def test_sulfuras_quality_never_decreases
    sulfuras = make_and_update(name: 'Sulfuras, Hand of Ragnaros', sell_in: 0, quality: 80)
    assert_equal 80, sulfuras.quality
  end

  def test_sulfuras_never_has_to_be_sold
    sulfuras = make_and_update(name: 'Sulfuras, Hand of Ragnaros', sell_in: 0, quality: 80)
    assert_equal 0, sulfuras.sell_in
  end

  # - "Backstage passes", like aged brie, increases in Quality as it's
  #   SellIn value approaches;
  def test_backstage_passes_over_10_days
    passes = make_and_update(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20)
    assert_equal 21, passes.quality
  end

  # Quality increases by 2 when there are 10
  # days or less
  def test_backstage_passes_in_10_days_or_less
    passes = make_and_update(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 20)
    assert_equal 22, passes.quality
  end

  # and by 3 when there are 5 days or less
  def test_backstage_passes_in_5_days_or_less
    passes = make_and_update(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 20)
    assert_equal 23, passes.quality
  end

  # but Quality drops to 0 after the concert
  def test_backstage_passes_expire
    passes = make_and_update(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 20)
    assert_equal 0, passes.quality
  end

  # - The Quality of an item is never more than 50
  def test_backstage_passes_never_exceed_max_quality
    passes = make_and_update(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 1, quality: 49)
    assert_equal 50, passes.quality
  end

  def test_conjured_item_degrades_twice_as_fast
    skip
    conjured_cake = make_and_update(name: "Conjured Mana Cake", sell_in: 3, quality: 6)
    assert_equal 4, conjured_cake.quality
  end

  def test_expired_conjured_item_degrades_twice_as_fast
    skip
    conjured_cake = make_and_update(name: "Conjured Mana Cake", sell_in: 0, quality: 6)
    assert_equal 2, conjured_cake.quality
  end

  def test_conjured_item_quality_is_never_negative
    skip
    conjured_cake = make_and_update(name: "Conjured Mana Cake", sell_in: 0, quality: 3)
    assert_equal 0, conjured_cake.quality
  end

end