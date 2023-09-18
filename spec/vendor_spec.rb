require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Item do
  before(:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  describe '#initialize' do 
    it 'exists' do
      expect(@vendor).to be_an_instance_of(Vendor)
    end

    it 'has attributes' do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
      expect(@vendor.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'returns the count of queried item if there are none in stock' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end

    it 'returns the count of queried item if there are some in stock' do
      @vendor.stock(@item1, 30)
      expect(@vendor.check_stock(@item1)).to eq(30)
    end
  end

  describe '#stock' do
    it 'puts an item into stock' do
      @vendor.stock(@item1, 30)
      expect(@vendor.inventory[@item1]).to eq(30)
    end

    it 'puts an item into stock if there are already items' do
      @vendor.stock(@item1, 30)
      @vendor.stock(@item2, 25)
      
      expect(@vendor.inventory[@item2]).to eq(25)

      @vendor.stock(@item1, 25)

      expect(@vendor.inventory[@item1]).to eq(55)
    end
  end
end