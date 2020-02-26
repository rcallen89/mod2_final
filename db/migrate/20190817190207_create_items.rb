class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :image, default: "https://www.wpclipart.com/office/sale_promo/new_item/new_item_light_red.png"
      t.boolean :active?, default: true
      t.integer :inventory
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
