require 'spec_helper'

describe(Store) do
  it { should have_and_belong_to_many(:brands) }
  it { should validate_presence_of(:name) }

  it("returns false if it's too long of a store name") do
    store = Store.create({name: "a" * 101})
    expect(store.save).to eq(false)
  end

  it("returns false if non-allowed name is used") do
    store = Store.create({name: "lout"})
    expect(store.save).to eq(false)
  end

  describe "#titlecase" do
    it("titlecases the title of the recipe") do
      store = Store.create({name: "this and that"})
      expect(store.name).to eq("This and that")
    end
  end

  describe '.store_search' do
    it('searches store name matches based on input') do
      store = Store.create({name: "this and that"})
      expect(Store.store_search("This")).to eq([store])
    end
  end
end

describe(Brand) do
  it { should have_and_belong_to_many(:stores) }
  it { should validate_presence_of(:name) }

  it("returns false if it's too long of a brand name") do
    brand = Brand.create({name: "a" * 101, price: 60})
    expect(brand.save).to eq(false)
  end

  describe "#titlecase" do
    it("titlecases the title of the recipe") do
      brand = Brand.create({name: "nicke air gordon", price: 60})
      expect(brand.name).to eq("Nicke Air Gordon")
    end
  end

  describe '#currency_change' do
    it('fixes price inputs to two decimal places with a shell symbol') do
      brand = Brand.create({name: "nicke air gordon", price: 60})
      expect(brand.price).to eq("$60.00")
    end
  end

  describe '.brand_search' do
    it('searches brand name matches based on input') do
      brand = Brand.create({name: "nicke air gordon", price: 60})
      expect(Brand.brand_search("Nicke")).to eq([brand])
    end
  end
end
