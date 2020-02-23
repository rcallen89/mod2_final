class AddTimeStampsToMerchantEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :merchant_employees, :created_at, :datetime, null: false
    add_column :merchant_employees, :updated_at, :datetime, null: false
  end
end
