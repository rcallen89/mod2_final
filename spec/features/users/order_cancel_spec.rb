require 'rails_helper'

RSpec.describe 'User Order Show Page', type: :feature do
  before :each do
    @user = create(:user)
    @bone = create(:item)
    @bone2 = create(:item, name: "bone2")
    @bone3 = create(:item, name: "bone3")
    @order1 = @user.orders.create(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 0, user: @user)
    @order1.item_orders.create!(item: @bone, price: @bone.price, quantity: 2, status: 1)
    @order1.item_orders.create!(item: @bone2, price: @bone2.price, quantity: 4)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'should see a button to cancel the order and items status is update and inventory returned' do


    visit "/profile/orders/#{@order1.id}"

    expect(@order1.item_orders.first.status).to eq("Fulfilled")

    click_on "Cancel Order"

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Order #{@order1.id} Cancelled")

    expect(@bone.inventory).to eq(7)


    click_on "My Orders"

    expect(current_path).to eq('/profile/orders')

    within "#order-#{@order1.id}" do
      expect(page).to have_content("Cancelled")
    end
  end
end