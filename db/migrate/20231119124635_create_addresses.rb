class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address_line
      t.string :city
      t.string :county
      t.string :post_code

      t.timestamps
    end
  end
end
