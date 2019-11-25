def increment_quality(item)
  if item.quality < 50
    item.quality += 1
  end
end

def update_item_quality(item)
  if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
    if item.name != 'Sulfuras, Hand of Ragnaros'
      decrement_quality(item)
    end
  else
    if item.quality < 50
      item.quality += 1
      if item.name == 'Backstage passes to a TAFKAL80ETC concert'
        if item.sell_in < 11
          increment_quality(item)
        end
        if item.sell_in < 6
          increment_quality(item)
        end
      end
    end
  end
end

def update_sell_in(item)
  if item.name != 'Sulfuras, Hand of Ragnaros'
    item.sell_in -= 1
  end
end

def decrement_quality(item)
  if item.quality > 0
    item.quality -= 1
  end
end

def handle_expiry(item)
  if item.name == "Aged Brie"
    increment_quality(item) && return
  end

  if item.name != 'Backstage passes to a TAFKAL80ETC concert'
    if item.name != 'Sulfuras, Hand of Ragnaros'
      decrement_quality(item)
    end
  else
    item.quality = 0
  end

end

def update_quality(items)
  items.each do |item|
    update_item_quality(item)
    update_sell_in(item)
    if item.sell_in < 0
      handle_expiry(item)
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

