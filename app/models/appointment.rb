class Appointment < ActiveRecord::Base
  attr_accessor :date,
    :description,
    :street1,
    :street2,
    :city,
    :state,
    :zipcode,
    :tag_list
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
  acts_as_taggable

  def full_address
    "#{street1}, #{street2 unless blank?}, #{city}, #{state} #{zipcode}"
  end
  alias_method :address, :full_address


  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
