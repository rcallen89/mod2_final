require 'rails_helper'

RSpec.describe 'User Profile Page', type: :feature do
  before :each do
    @user = create(:user)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  context 'as a registered user' do
    it 'can see all profile data expect password with link to edit profile and edit password' do
      visit '/profile'

      within "#user-info" do
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.street_address)
        expect(page).to have_content(@user.city)
        expect(page).to have_content(@user.state)
        expect(page).to have_content(@user.zip)
        expect(page).to have_content(@user.email)
        
        expect(page).not_to have_content(@user.password)

        expect(page).to have_link("Edit Profile")
        expect(page).to have_link("Change Password")
      end
    end

    it 'if user has no orders wont see a link to My Orders' do
      visit '/profile'

      expect(page).not_to have_link("My Orders")
    end

    it 'if user has orders they will see a link to my orders' do
      @user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218)
      
      visit '/profile'

      click_on "My Orders"

      expect(current_path).to eq('/profile/orders')
    end
  end
end