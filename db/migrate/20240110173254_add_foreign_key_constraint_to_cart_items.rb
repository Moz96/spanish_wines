class AddForeignKeyConstraintToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :cart_items, :products, on_delete: :cascade
  end
end
