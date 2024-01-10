class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  after_create :create_cart
  has_one :cart, dependent: :destroy

  private

  def create_cart
    Cart.create(user: self)
  end
end
