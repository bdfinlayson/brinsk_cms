class Goal < ApplicationRecord
  belongs_to :contact
  validates_presence_of :objective, :contact_id

  scope :current_goals, -> { where(current: true) }
end
