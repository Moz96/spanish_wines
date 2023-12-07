class Product < ApplicationRecord
  has_many :reviews
  has_many :orders
  has_and_belongs_to_many :product
end
