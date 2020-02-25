require 'rails_helper'

RSpec.describe "As an admin user,", type: :feature do 
    describe "when I visit the merchant index page and click a merchants name" do 
        before :each do
            @user = create(:user, name: "Francisco", role: 2)
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
            
            @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
            @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
        end
        it "then I go to /admin/mechant/:id and see everything a merchant would see." do 
            visit "/merchants"

            click_link "Brian's Bike Shop"

            expect(current_path).to eq("/admin/merchants/#{@bike_shop.id}")
            expect(page).to have_content("Brian's Bike Shop")
            expect(page).to have_content("123 Bike Rd.\nRichmond, VA 80203")
        end 
    end
end