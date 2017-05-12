require "spec_helper"

describe('adding a store', {:type => :feature}) do
  it('allows a user to add a store to the website') do
    visit('/')

    fill_in('store_name', :with =>'shoe dudes')

    click_button('add store')
    expect(page).to have_content('Shoe Assist 720')
  end
end
