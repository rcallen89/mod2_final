require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  describe "I see the same links as a visitor" do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    end
    it "plus the following links" do

      visit "/merchants"

      within 'nav' do
        click_link 'My Profile'
      end

      expect(current_path).to eq('/profile')

      # within 'nav' do
      #   click_link 'Logout'
      # end

      # expect(current_path).to eq('/profile')

      expect(page).to have_link('Logout')
    end
    it "I cannot see a link to login or register" do

      visit "/merchants"

      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Register")
    end
    it "can see message saying user is logged in" do

      visit "/merchants"
       within 'nav' do
         expect(page).to have_content("Logged in as Benny")
       end
    end
  end
end
