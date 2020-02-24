require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
    it {should have_many(:merchants).through(:items)}
  end

  describe 'instance methods' do
    before :each do
      @user = create(:user)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @pull_toy2 = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0, user: @user)
      @order_2 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 1, user: @user)
      @order_3 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 2, user: @user)
      @order_4 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 3, user: @user)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
      @order_1.item_orders.create!(item: @pull_toy2, price: @pull_toy2.price, quantity: 3)

      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end

    it 'status is controlled by enum' do
      expect(@order_2.status).to eq("Pending")
      expect(@order_1.status).to eq("Packaged")
      expect(@order_3.status).to eq("Shipped")
      expect(@order_4.status).to eq("Cancelled")
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(260)
    end

    it 'total_items' do
      expect(@order_1.total_items).to eq(8)
    end

    it 'creation' do
      expect(@order_1.creation).to eq(Date.today)
    end

    it 'updated' do
      expect(@order_1.updated).to eq(Date.today)
    end

    it 'item_table' do
      expect(@order_1.item_table).to eq([@tire, @pull_toy, @pull_toy2])
      expect(@order_1.item_table.first[:qty]).to eq(2)
    end

    it 'current_status' do
      order = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 1, user: @user)
      item1 = order.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      item2 =order.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)

      expect(order.current_status).to eq("Pending")

      item1.update(status: 1)

      expect(order.current_status).to eq("Pending")

      item2.update(status: 1)

      expect(order.current_status).to eq("Packaged")

    end
  end
end
