class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy

  validates :nickname, uniqueness: true
end
