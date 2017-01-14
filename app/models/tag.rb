class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tasks, through: :taggings, source: 'taggable', source_type: 'Task'

  validates :name, presence: true
  validates :user_id, presence: true
  validates :color, presence: true

  default_scope -> { order(name: :asc) }
end
