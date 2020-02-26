require 'rails_helper'

RSpec.describe "Merchant Dashboard My Items Page" do
  before :each do
      @user = create(:user, name: "Francisco", role: 1)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @dog_shop.users << @user

      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @dog_leash = @dog_shop.items.create(name: "Dog Leash", description: "Doggy Prison!", price: 21, image: "https://cdn.shopify.com/s/files/1/1728/3089/products/small_dog_leash_-_teal_800x.jpg?v=1555617800", inventory: 21)

      @order_1 = Order.create!(name: 'Brian', address: '123 Doggo St.', city: 'Denver', state: 'CO', zip: 80210, user: @user)
      @order_1.item_orders.create!(item: @dog_leash, price: 12, quantity: 3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'can see a button to add a new item' do
    visit "/merchant/items"

    expect(page).to have_link("New Item")
  end
  it "can see a delete button next to each item" do

    visit "/merchant/items"

    within "#item-#{@pull_toy.id}" do
      expect(page).to have_link("Delete Item")
    end


    within "#item-#{@dog_bone.id}" do
      expect(page).to have_link("Delete Item")
      click_on "Delete Item"
    end

    expect(current_path).to eq("/merchant/items")
    expect(page).to_not have_css("#item-#{@dog_bone.id}")
    expect(page).to have_content("#{@dog_bone.name} has been removed from items")
  end

  it "cannot delete an item if it is part of a order" do

    visit "/merchant/items"

    within "#item-#{@dog_leash.id}" do
      expect(page).to_not have_link("Delete Item")
    end
  end
end
