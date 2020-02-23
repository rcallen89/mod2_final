require 'rails_helper'

RSpec.describe 'User Order Show Page', type: :feature do
  before :each do
    @user = create(:user)
    @bone = create(:item)
    @bone2 = create(:item, name: "bone2")
    @bone3 = create(:item, name: "bone3")
    @order1 = @user.orders.create(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 0, user: @user)
    @order1.item_orders.create!(item: @bone, price: @bone.price, quantity: 2)
    @order1.item_orders.create!(item: @bone2, price: @bone2.price, quantity: 4)

    @order2 = @user.orders.create(name: 'Meg 2', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, status: 0, user: @user)
    @order2.item_orders.create!(item: @bone3, price: @bone3.price, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

end