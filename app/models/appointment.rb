class Appointment < ActiveRecord::Base
  belongs_to :appointable, polymorphic: true
  belongs_to :user
  validates :date, presence: true
  validate :date_cannot_be_in_the_past
  validates :user_id, presence: true
  validates :description, length: { maximum: 300 }, allow_blank: true
  validates :street1, presence: true
  validates :street2, length: { maximum: 100 }, allow_blank: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
