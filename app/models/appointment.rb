class Appointment < ActiveRecord::Base
  extend SimpleCalendar
  belongs_to :appointable, polymorphic: true
  belongs_to :user
  belongs_to :project
  belongs_to :contact
  validates :name, presence: true
  # validates_uniqueness_of :name, scope: :user_id
  # validates_uniqueness_of :starts_at, scope: :user_id
  validates :starts_at, presence: true
  validate :date_cannot_be_in_the_past
  validates :user_id, presence: true
  # validates :description, length: { maximum: 300 }, allow_blank: true
  # validates :street1, presence: true
  # validates :street2, length: { maximum: 100 }, allow_blank: true
  # validates :city, presence: true
  # validates :state, presence: true
  # validates :zipcode, presence: true
  acts_as_taggable

  geocoded_by :street1
  after_validation :geocode

  def full_address
    "#{street1}, #{street2 unless blank?}, #{city}, #{state} #{zipcode}"
  end
  alias_method :address, :full_address


  def date_cannot_be_in_the_past
    if starts_at.present? && starts_at < Date.today
      errors.add(:starts_at, "can't be in the past")
    end
  end
end
