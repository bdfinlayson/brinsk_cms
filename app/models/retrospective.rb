class Retrospective < ApplicationRecord
  validates_presence_of :what_has_gone_well, :what_has_gone_poorly, :how_are_your_goals, :contact_id
  belongs_to :contact
end
