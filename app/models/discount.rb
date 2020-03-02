class Discount < ApplicationRecord
  belongs_to :merchant

  validates_numericality_of :percentage, greater_than_or_equal_to: 5.0, less_than_or_equal_to: 50.0, message: "not in range"
  validates_numericality_of :per_item, greater_than_or_equal_to: 1, less_than_or_equal_to: 20, message: "not in range"
end