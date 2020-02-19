require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  context "When I try to access a restricted path" do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it "Then I see a 404 error" do

      visit "/merchant"

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/admin"

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
