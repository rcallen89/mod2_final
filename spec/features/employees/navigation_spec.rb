require 'rails_helper'

RSpec.describe "As a merchant employee", type: :feature do
  describe "I see the same links as a user" do
    before :each do
      @user = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "plus the following" do

      visit "/merchants"

      within 'nav' do
        click_link 'My Profile'
      end
      expect(current_path).to eq('/profile')

      within 'nav' do
        click_link 'Logout'
      end
      expect(current_path).to eq('/')

      within 'nav' do
        click_link 'Merchant Dashboard'
      end
      expect(current_path).to eq('/merchant')
    end
  end
end
