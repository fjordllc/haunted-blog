# frozen_string_literal: true

class Liking < ApplicationRecord
  belongs_to :blog
  belongs_to :user

  validates :user_id, uniqueness: { scope: :blog_id }
end
