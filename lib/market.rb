require 'date'

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    names = @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors = @vendors.select do |vendor|
      vendor.inventory[item] > 0
    end
  end

  def sorted_item_list
    items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        items << item.name
      end
    end
    items.uniq.sort
  end

  def total_inventory
    item_list = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        item_list[item] ||= { quantity: 0, vendors: [] }
        item_list[item][:quantity] += quantity
        item_list[item][:vendors] << vendor
      end
    end
    item_list
  end

  def overstocked_items
    overstocked_list = []
    total_inventory.each do |item, details|
      if details[:quantity] > 50 && details[:vendors].count > 1
        overstocked_list << item
      end
    end
    overstocked_list
  end

  def sell(item, quantity)
    
  end
end