class Task < ActiveRecord::Base
  belongs_to :taskable, polymorphic:true
  validates :name, presence: true, length: { maximum: 50 }
  # validates :due, presence: true
  # validate :due_date_cannot_be_in_the_past
  acts_as_taggable

  state_machine :initial => :inbox do
    event :working do
      transition [:inbox, :completed] => :working
    end

    event :completed do
      transition [:inbox, :working] => :completed
    end

    event :inbox do
      transition [:working, :completed] => :inbox
    end
  end

  def self.search(search)
    if search
      where('name like ? or description like ? or taskable_type like ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      []
    end
  end


  def due_date_cannot_be_in_the_past
    if due.present? && due < Date.today
      errors.add(:due, "can't be in the past")
    end
  end
end
