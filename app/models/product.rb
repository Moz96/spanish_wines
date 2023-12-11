class Product < ApplicationRecord
  has_many :reviews
  has_many :orders
  has_many :cart_items
  has_many :carts, through: :cart_items
end
