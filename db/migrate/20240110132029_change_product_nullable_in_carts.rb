class ChangeProductNullableInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column :carts, :product_id, :bigint, null: true
  end
end
