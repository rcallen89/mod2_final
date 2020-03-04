require 'rails_helper'

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of(:percentage).with_message("not in range") }
    it { should validate_presence_of(:per_item).with_message("not in range") }
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end
end