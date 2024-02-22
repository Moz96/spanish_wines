class Product < ApplicationRecord
  validates :name, :description, :price, :vintage, :quantity, :category, presence: true
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_one_attached :image, dependent: :destroy
end
