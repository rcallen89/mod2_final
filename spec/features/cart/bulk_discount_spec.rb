require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount', type: :feature do
  before :each do
    @user = create(:user)
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
    @bike_shop.discounts.create!(percentage: 10, per_item: 2)
    @bike_shop.discounts.create!(percentage: 20, per_item: 4)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 25)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 100, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 15)
    @shifter = @bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 100, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 10)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@chain.id}"
    click_on "Add To Cart"
    visit "/items/#{@shifter.id}"
    click_on "Add To Cart"
  end

  it 'will show a item discount when reaching the per_item threshold' do
    visit '/cart'

    within "#cart-item-#{@tire.id}" do
      click_on "Add Quantity"
    end

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content("$180.00")
      expect(page).to have_content("10% off for bulk discount!")
    end

    expect(page).to have_content("Total: $380.00")
  end

  it 'will apply the biggest discount if there is more than one' do
    visit '/cart'

    within "#cart-item-#{@tire.id}" do
      click_on "Add Quantity"
      click_on "Add Quantity"
      click_on "Add Quantity"
    end

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_content("$320.00")
      expect(page).to have_content("20% off for bulk discount!")
    end

    expect(page).to have_content("Total: $520.00")
  end
end

