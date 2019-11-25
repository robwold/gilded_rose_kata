MINIMUM_ITEM_QUALITY = 0
MAXIMUM_ITEM_QUALITY = 50


SPECIFIC_ITEMS = {
    :SULFURAS => "Sulfuras, Hand of Ragnaros",
    :BACKSTAGE_PASSES => "Backstage passes to a TAFKAL80ETC concert",
    :AGED_BRIE => "Aged Brie"
}

def update_quality(items)
  items.each do |item|

    if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
      if item.quality > MINIMUM_ITEM_QUALITY
        if item.name != 'Sulfuras, Hand of Ragnaros'
          item.quality -= 1
        end
      end
    else
      if item.quality < MAXIMUM_ITEM_QUALITY
        item.quality += 1
        if item.name == SPECIFIC_ITEMS[:BACKSTAGE_PASSES]
          backstage_passes_rules(item)
        end
      end
    end
    if item.name != 'Sulfuras, Hand of Ragnaros'
      item.sell_in -= 1
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality > MINIMUM_ITEM_QUALITY
            if item.name != 'Sulfuras, Hand of Ragnaros'
              item.quality -= 1
            end
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

private
def backstage_passes_rules(item)
  if item.sell_in < 11
    if item.quality < MAXIMUM_ITEM_QUALITY
      item.quality += 1
    end
  end
  if item.sell_in < 6
    if item.quality < MAXIMUM_ITEM_QUALITY
      item.quality += 1
    end
  end
end

def decrease_quality(item)
  if item.sell_in < 0
    item.quality = item.quality - 2
  else
    item.quality = item.quality - 1
  end
end


# def quality_more_than_zero(item_name)
#   if item.name != 'Sulfuras, Hand of Ragnaros'
#     item.quality -= 1
#   end
# end

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

