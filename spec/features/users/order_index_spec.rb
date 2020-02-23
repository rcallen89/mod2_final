require 'rails_helper'

RSpec.describe 'User Order Index Page', type: :feature do
  before :each do
    @user = create(:user)
    bone = create(:item)
    @order1 = @user.orders.create(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 0, user: @user)
    @order1.item_orders.create!(item: bone, price: bone.price, quantity: 2)

    @order2 = @user.orders.create(name: 'Meg 2', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 0, user: @user)
    @order2.item_orders.create!(item: bone, price: bone.price, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'should show a detailed break down of each order' do
    visit '/profile/orders'

    within "#order-#{@order1.id}" do
      expect(page).to have_content(@order1.id)
      expect(page).to have_content(@order1.total_items)
      expect(page).to have_content(@order1.grandtotal)
      expect(page).to have_content(@order1.status)
      expect(page).to have_content(@order1.creation)
      expect(page).to have_content(@order1.updated)
    end

    within "#order-#{@order2.id}" do
      expect(page).to have_content(@order2.id)
      expect(page).to have_content(@order2.total_items)
      expect(page).to have_content(@order2.grandtotal)
      expect(page).to have_content(@order2.status)
      expect(page).to have_content(@order2.creation)
      expect(page).to have_content(@order2.updated)
    end
  end
end