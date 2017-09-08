class Goal < ApplicationRecord
  belongs_to :contact
  validates_presence_of :objective, :contact_id

  scope :current, -> { where(current: true) }
  scope :achieved, -> { where(achieved: true) }
  scope :unachieved, -> { where.not(achieved: true) }
end
