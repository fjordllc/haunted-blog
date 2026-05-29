# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :user
  has_many :likings, dependent: :destroy
  has_many :liking_users, class_name: 'User', source: :user, through: :likings

  validates :title, :content, presence: true

  scope :published, -> { where('secret = FALSE') }

  scope :search, lambda { |term|
    return all if term.blank?

    escaped_term = ActiveRecord::Base.sanitize_sql_like(term)
    keyword = "%#{escaped_term}%"
    where('title LIKE :keyword OR content LIKE :keyword', keyword: keyword)
  }

  scope :default_order, -> { order(id: :desc) }

  def owned_by?(target_user)
    user == target_user
  end
end
