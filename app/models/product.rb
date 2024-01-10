class Product < ApplicationRecord
  validates :name, :description, :price, :vintage, :quantity, :category, presence: true
  has_many :reviews
  has_many :orders
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_one_attached :image
end
