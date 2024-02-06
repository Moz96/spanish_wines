class ChangeOrderAttributes < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :total_price
    remove_column :orders, :user_id
    remove_column :orders, :product_id
    remove_column :orders, :total_price
    add_column :orders, :session_id, :string
    add_column :orders, :status, :integer
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
