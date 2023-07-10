class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :user_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, default: 1
      t.integer :totalamount
      t.index :product_id, unique: true

      t.timestamps
    end
  end
end
