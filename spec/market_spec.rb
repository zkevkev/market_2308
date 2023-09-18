require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new({name: "Peach", price: "$0.75"})
    @item2 = Item.new({name: "Tomato", price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom") 
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1.stock(@item1, 35) 
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)   
    @vendor2.stock(@item3, 75)
    @vendor2.stock(@item2, 10)
    @vendor3.stock(@item1, 65)  
    @market.add_vendor(@vendor1) 
    @market.add_vendor(@vendor2) 
    @market.add_vendor(@vendor3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@market).to be_an_instance_of(Market)
    end

    it 'has attributes' do
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to be_a(Array)
    end
  end

  describe '#add_vendor' do
    it 'adds a vendor to the vendor array' do
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end

  describe '#vendor_names' do
    it 'returns an array of available vendor names' do
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#vendors_that_sell' do
    it 'returns a list of vendors that have the queried item' do
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe '#sorted_item_list' do
    it 'returns an alphabetical array of item names that are in stock' do
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  describe '#total_inventory' do
    it 'returns a hash of of all items being sold' do
      expect(@market.total_inventory[@item2]).to eq({quantity: 17, vendors: [@vendor1, @vendor2]}) 
      expect(@market.total_inventory[@item1]).to eq({quantity: 100, vendors: [@vendor1, @vendor3]}) 
    end
  end

  describe '#overstocked_items' do
    xit 'returns an array of items that are sold by >1 vendor and have a quantity >50' do
      expect(@market.overstocked_items).to eq([@item1])

      @vendor1.stock(@item2, 33)

      expect(@market.overstocked_items).to eq([@item1])

      @vendor1.stock(@item2, 1)

      expect(@market.overstocked_items).to eq([@item1, @item2])

      @vendor3.stock(@item3, 1)

      expect(@market.overstocked_items).to eq([@item1, @item2, @item3])
    end
  end
end