class Contact < ActiveRecord::Base
  belongs_to :user
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  before_save { email.downcase! }
  # validates_uniqueness_of :email, scope: :user_id
  before_save { self.email = email.downcase }
  has_many :notes, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :tasks, :as => :taskable
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings, as: :taggable

  def full_address
    "#{street1}, #{street2 unless blank?}, #{city}, #{state} #{zipcode}"
  end
  alias_method :address, :full_address

  def full_name
    "#{first_name} #{last_name}"
  end
end
