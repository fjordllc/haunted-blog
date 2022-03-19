class Blog < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true

  scope :published, -> { where("secret = FALSE") }

  scope :search, -> (term) do
    where("title LIKE '%#{term}%' OR content LIKE '%#{term}%'")
  end

  scope :default_order, -> { order(id: :desc) }
end
