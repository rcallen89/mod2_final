require 'rails_helper'

RSpec.describe "Admin Order Index Page", type: :feature do
  before :each do
    @user = create(:user)
    @admin = create(:user, role: 2, email: "admin123@email.com")
    bone = create(:item)
    @order1 = @user.orders.create(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 0)
    @order1.item_orders.create!(item: bone, price: bone.price, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it 'can see all orders in the system with Linked User, Order ID, and Date. Ordered by Status' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit "/admin"

    within "#order-#{@order1.id}" do
      expect(page).to have_link("#{@order1.user.name}")
      expect(page).to have_content(@order1.id)
      expect(page).to have_content(@order1.creation)
      expect(page).to have_content("Packaged")
      click_on "Ship Order"
    end

    expect(current_path).to eq("/admin")
      within "#order-#{@order1.id}" do
      expect(page).to have_link("#{@order1.user.name}")
      expect(page).to have_content(@order1.id)
      expect(page).to have_content(@order1.creation)
      expect(page).to have_content("Shipped")
      expect(page).not_to have_link("Ship Order")
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit "/profile/orders/#{@order1.id}"
    expect(page).not_to have_content("Cancel Order")

  end
end