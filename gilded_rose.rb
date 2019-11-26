require './gilded_rose_helper.rb'

SULFURAS = 'Sulfuras, Hand of Ragnaros'
AGED_BRIE = 'Aged Brie'
BACKSTAGE_PASS = 'Backstage passes to a TAFKAL80ETC concert'


MAXIMUM_ITEM_QUALITY = 50

class GildedRose
  include GildedRoseHelper

  def update_quality(items)
    items.each do |item|
      if item.name == SULFURAS
        sulfuras_rules(item)
      else
        if item.name != AGED_BRIE && item.name != BACKSTAGE_PASS
          if item.quality > 0
            item.quality -= 1
          end
        else
          if item.quality < MAXIMUM_ITEM_QUALITY
            item.quality += 1
            if item.name == BACKSTAGE_PASS
              backstage_passes_rules(item)
            end
          end
        end
        item.sell_in -= 1
        if item.sell_in < 0
          if item.name != AGED_BRIE
            if item.name != BACKSTAGE_PASS
              if item.quality > 0
                item.quality -= 1
              end
            else
              item.quality = item.quality - item.quality
            end
          else
            if item.quality < MAXIMUM_ITEM_QUALITY
              item.quality += 1
            end
          end
        end
      end
    end
  end
end
# DO NOT CHANGE THINGS BELOW -----------------------------------------

  Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

