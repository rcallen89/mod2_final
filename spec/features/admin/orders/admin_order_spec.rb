require 'rails_helper'

RSpec.describe "Admin Order Index Page", type: :feature do
  before :each do
    user = create(:user)
    @admin = create(:user, role: 2, email: "admin123@email.com")
    bone = create(:item)
    @order1 = user.orders.create(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 0, user: user)
    @order1.item_orders.create!(item: bone, price: bone.price, quantity: 2)

    @order2 = user.orders.create(name: 'Meg 2', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 2, user: user)
    @order2.item_orders.create!(item: bone, price: bone.price, quantity: 2)

    @order3 = user.orders.create(name: 'Meg 2', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 1, user: user)
    @order3.item_orders.create!(item: bone, price: bone.price, quantity: 2)

    @order4 = user.orders.create(name: 'Meg 2', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 3, user: user)
    @order4.item_orders.create!(item: bone, price: bone.price, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it 'can see all orders in the system with Linked User, Order ID, and Date. Ordered by Status' do
    visit "/admin"

    within "#order-#{@order1.id}" do
      expect(page).to have_link("#{@order1.user.name}")
      expect(page).to have_content(@order1.id)
      expect(page).to have_content(@order1.creation)
      expect(page).to have_content(@order1.status)
    end

    within "#order-#{@order2.id}" do
      expect(page).to have_link("#{@order2.user.name}")
      expect(page).to have_content(@order2.id)
      expect(page).to have_content(@order2.creation)
      expect(page).to have_content(@order2.status)
    end

    within "#order-#{@order3.id}" do
      expect(page).to have_link("#{@order3.user.name}")
      expect(page).to have_content(@order3.id)
      expect(page).to have_content(@order3.creation)
      expect(page).to have_content(@order3.status)
    end

    within "#order-#{@order4.id}" do
      expect(page).to have_link("#{@order4.user.name}")
      expect(page).to have_content(@order4.id)
      expect(page).to have_content(@order4.creation)
      expect(page).to have_content(@order4.status)
    end

  end
end