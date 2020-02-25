require 'rails_helper'

RSpec.describe 'Admin Merchant Index', type: :feature do
  before :each do
    @user = create(:user, role: 2)

    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @seat = @bike_shop.items.create(name: "Seat", description: "Comfy!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, active?: false)
    @dog_shop = Merchant.create!(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203, enabled?: false)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'should see a list of merchants with their city, state with active button' do
    visit '/admin/merchants'

    within "#merchant-#{@bike_shop.id}" do
      expect(page).to have_link("Brian's Bike Shop")
      expect(page).to have_content("Richmond, VA")
      expect(page).to have_link("Disable Merchant")
    end

    within "#merchant-#{@dog_shop.id}" do
      expect(page).to have_link("Meg's Dog Shop")
      expect(page).to have_content("Hershey, PA")
      expect(page).to have_link("Enable Merchant")
    end
  end

  it 'should be able to deactive a merchant and all their items' do
    visit '/admin/merchants'

    expect(@bike_shop.enabled?).to eq(true)

    within "#merchant-#{@bike_shop.id}" do
      click_on "Disable Merchant"
    end

    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("Merchant Brian's Bike Shop Disabled")

    within "#merchant-#{@bike_shop.id}" do
      expect(page).to have_link("Enable Merchant")
    end
  end

  it 'should be able to deactive a merchant and all their items' do
    visit '/admin/merchants'

    expect(@dog_shop.enabled?).to eq(false)

    within "#merchant-#{@dog_shop.id}" do
      click_on "Enable Merchant"
    end

    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("Merchant Meg's Dog Shop Enabled")


    within "#merchant-#{@dog_shop.id}" do
      expect(page).to have_link("Disable Merchant")
    end
  end
end