class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings

  validates :name, presence: true
  validates :user_id, presence: true
  validates :color, presence: true
end
