class Project < ActiveRecord::Base
  attr_accessor :name, :description, :start_date, :end_date, :completed, :tag_list
  belongs_to :user
  belongs_to :contact
  has_many :notes
  has_many :stages
  validates :user_id, presence: true
  validates :contact_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  has_many :appointments, :as => :appointable
  acts_as_taggable

end
