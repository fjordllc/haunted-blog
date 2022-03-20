# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
  has_many :likings, dependent: :destroy

  validates :nickname, uniqueness: true
end
