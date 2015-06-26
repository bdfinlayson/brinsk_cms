class Task < ActiveRecord::Base
  belongs_to :taskable, polymorphic:true
  validates :taskable_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 250 }
  # validates :due, presence: true
  # validate :due_date_cannot_be_in_the_past
  acts_as_taggable

  searchable do
    text :name, :description, :taskable_type
    time :due
    time :created_at
    time :updated_at
  end

  def due_date_cannot_be_in_the_past
    if due.present? && due < Date.today
      errors.add(:due, "can't be in the past")
    end
  end
end
