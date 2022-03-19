class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
end
