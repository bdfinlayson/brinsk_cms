class Retrospective < ApplicationRecord
  validates_presence_of :what_has_gone_well, :what_has_gone_poorly, :how_are_your_goals, :contact_id
  belongs_to :contact

  def full_content
    "What Has Gone Well: #{self.what_has_gone_well}; What Has Gone Poorly: #{self.what_has_gone_poorly}; How Are Your Goals: #{self.how_are_your_goals}"
  end
end
