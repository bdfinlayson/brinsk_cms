class Contact < ActiveRecord::Base
  belongs_to :user
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates_uniqueness_of :email
  before_save { email.downcase! }
  before_save { self.email = email.downcase }
  has_many :notes
  has_many :projects

end
