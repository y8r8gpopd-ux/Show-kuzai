class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :fridge_items
  has_many :cooking_histories
  has_many :shopping_lists

  validates :password, format:{with: /\A[a-z0-9]{6,}\z/i }, allow_blank: true
end
