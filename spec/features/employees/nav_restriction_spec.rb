require 'rails_helper'

RSpec.describe "As a merchant employee", type: :feature do
  describe "When I try to access a restricted path" do
    before :each do
      @user = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "then I see a 404 error" do
      visit "/admin"

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
