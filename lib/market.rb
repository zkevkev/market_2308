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
end