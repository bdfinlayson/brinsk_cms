class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable

  validates :tag_id, presence: true
  validates :taggable_id, presence: true
  validates :taggable_type, presence: true
end
