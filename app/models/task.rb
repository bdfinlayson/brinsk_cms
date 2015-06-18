class Task < ActiveRecord::Base
  attr_accessor :name, :description, :due, :completed, :tag_list
  belongs_to :user
  belongs_to :taskable, polymorphic:true
  validates :taskable_id, presence: true
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 250 }
  validates :due, presence: true
  validate :due_date_cannot_be_in_the_past
  acts_as_taggable

  def due_date_cannot_be_in_the_past
    if due.present? && due < Date.today
      errors.add(:due, "can't be in the past")
    end
  end
end
