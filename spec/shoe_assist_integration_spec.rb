require "spec_helper"

describe('adding a store', {:type => :feature}) do
  it('allows a user to add a store to the website') do
    visit('/')

    fill_in('store_name', :with =>'shoe dudes')

    click_button('add store')
    expect(page).to have_content('Shoe Assist 720')
  end
end

describe('adding a brand', {:type => :feature}) do
  it('allows a user to add a brand to the website') do
    visit('/')

    fill_in('brand_name', :with =>'Nickes')
    fill_in('brand_price', :with => '44.99')

    click_button('add brand')
    expect(page).to have_content('Shoe Assist 720')
  end
end

describe('viewing a store', {:type => :feature}) do
  it('allows a user to view a store') do
    store = Store.create({name: "shoe fly guys"})
    visit("/store/#{store.id}")

    expect(page).to have_content('Shoe Fly Guys')
  end
end

describe('viewing a brand', {:type => :feature}) do
  it('allows a user to view a brand') do
    brand = Brand.create({name: "nicke air gordon", price: 60})
    visit("/brand/#{brand.id}")

    expect(page).to have_content('Nicke Air Gordon')
  end
end

describe('updating store name', {:type => :feature}) do
  it('allows a user change name of a store') do
    store = Store.create({name: "shoe fly guys"})
    visit("/store/#{store.id}")
    fill_in('store_name', :with => 'Footies R Us')
    click_button('edit store name')
    expect(page).to have_content('Footies R Us')
  end
end

describe('deleting a store', {:type => :feature}) do
  it('allows a user change name of a store') do
    store = Store.create({name: "shoe fly guys"})
    visit("/store/#{store.id}")
    click_button('close store')
    expect(page).to have_content('Shoe Assist 720')
  end
end

describe('adding a brand to a store', {:type => :feature}) do
  it('allows a user change name of a store') do
    store = Store.create({name: "shoe fly guys"})
    brand = Brand.create({name: "nicke air gordon", price: 60})
    visit("/store/#{store.id}")
    click_button('add to store')
    expect(page).to have_content('Nicke Air Gordon')
  end
end

describe('deleting a brand', {:type => :feature}) do
  it('allows a user delete a brand') do
    brand = Brand.create({name: "nicke air gordon", price: 60})
    visit("/brand/#{brand.id}")
    click_button('liquidate brand')
    expect(page).to have_content('Shoe Assist 720')
  end
end

describe('updating brand name', {:type => :feature}) do
  it('allows a user change name of a brand') do
    brand = Brand.create({name: "nicke air gordon", price: 60})
    visit("/brand/#{brand.id}")
    fill_in('brand_name', :with => 'burrito feet')
    click_button('edit brand name')
    expect(page).to have_content('Burrito Feet')
  end
end
