require 'rails_helper'

RSpec.describe "As an merchant employee,", type: :feature do
    before :each do
        @user = create(:user, name: "Francisco", role: 1)
        @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

        @bike_shop.users << @user
        
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe "then I visit merchant dashboard" do
        it "then I see a link to view my own items that takes me to /merchant/items" do
            visit "/merchant"
            click_link "My Items"
            expect(current_path).to eq(merchant_items_path)
        end
    end
end
