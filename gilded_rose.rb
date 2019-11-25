class ItemUpdater

  def self.updater_for(item)
    return SulfurasUpdater.new if item.name == 'Sulfuras, Hand of Ragnaros'
    ItemUpdater.new
  end

  def update_item(item)
    update_item_quality(item)
    update_sell_in(item)
    if item.sell_in < 0
      handle_expiry(item)
    end
  end

  private
  def increment_quality(item)
    if item.quality < 50
      item.quality += 1
    end
  end

  def update_item_quality(item)
    if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      increment_quality(item)
      increment_quality(item) if item.sell_in < 11
      increment_quality(item) if item.sell_in < 6
      return
    end

    if item.name == 'Aged Brie'
      increment_quality(item)
      return
    end

    decrement_quality(item)
  end

  def update_sell_in(item)
    item.sell_in -= 1
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

    if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      item.quality = 0
      return
    end

    decrement_quality(item)
  end
end

class SulfurasUpdater < ItemUpdater
  def update_item_quality(item); end
  def update_sell_in(item); end
  def handle_expiry(item); end
end

def update_quality(items)
  items.each do |item|
    updater = ItemUpdater.updater_for(item)
    updater.update_item(item)
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

