class Task < ActiveRecord::Base
  belongs_to :taskable, polymorphic:true
  belongs_to :user
  validates :user_id, presence: true

  belongs_to :contact

  default_scope -> { order(position: :asc).where.not(state: 'archived') }

  scope :working, -> { where(state: 'working') }
  scope :inbox, -> { where(state: 'inbox') }

  validates :name, presence: true, length: { maximum: 50 }
  # validate :due_date_cannot_be_in_the_past

  STATES = %w(inbox working completed)

  state_machine :initial => :inbox do

    after_transition any => :working, do: :update_started_at
    after_transition any => :completed, do: :update_completed_at

    event :inbox do
      transition [:working, :completed] => :inbox
    end

    event :working do
      transition [:inbox, :completed] => :working
    end

    event :completed do
      transition [:inbox, :working] => :completed
    end

    event :archived do
      transition [:completed] => :archived
    end
  end

  def update_started_at
    update(started_at: Time.current)
  end

  def update_completed_at
    update(completed_at: Time.current)
  end

  def due_date_cannot_be_in_the_past
    if due.present? && due < Date.today
      errors.add(:due, "can't be in the past")
    end
  end
end
