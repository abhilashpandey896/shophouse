class RemoveIndexFromCart < ActiveRecord::Migration[7.0]
  def change
    remove_index "carts", column: [:product_id], name: "index_carts_on_product_id"
  end
end
