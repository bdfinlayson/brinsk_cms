class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy

  validates :name, presence: true
  validates :user_id, presence: true
  validates :color, presence: true

  default_scope -> { order(name: :asc) }
end
