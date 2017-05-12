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
  it('allows a user to add a store to the website') do
    store = Store.create({name: "shoe fly guys"})
    visit("/store/#{store.id}")

    expect(page).to have_content('Shoe Fly Guys')
  end
end
