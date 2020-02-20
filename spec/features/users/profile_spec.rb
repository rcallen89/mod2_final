require 'rails_helper'

RSpec.describe 'User Profile Page', type: :feature do
  before :each do
    @user = create(:user)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  context 'as a registered user' do
    it 'can see all profile data expect password with link to edit' do
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
      end
    end
  end
end