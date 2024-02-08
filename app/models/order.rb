class Order < ApplicationRecord
  belongs_to :user
  has_many :products
  enum status: {
    pending: 0,
    paid: 1
  }
end
