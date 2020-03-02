require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount', type: :feature do
  before :each do
    @user = create(:user, role: 1)
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
    @bike_shop.users << @user
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 25)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 100, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 15)
    @shifter = @bike_shop.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 100, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 10)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

  end

  context 'as a merchant employee' do
    it 'can see a link on the dashboard to create a new bulk discount' do
      visit '/merchant'

      click_on "New Bulk Discount"

      expect(current_path).to eq('/merchant/discounts/new')
    end


    it 'can see a delete button next to each discount which removes the discount' do
      discount = @bike_shop.discounts.create!(percentage: 10, per_item: 2)

      visit '/merchant'

      within "#discounts-#{discount.id}" do
        click_on "Delete Discount"
      end

      expect(current_path).to eq('/merchant')

      expect(page).not_to have_css("#discounts-#{discount.id}")
    end
  end
end