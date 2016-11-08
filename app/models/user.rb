class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :password, length: { minimum: 8 }
  validates :first_name, length: { maximum: 15 }, presence: true
  validates :last_name, length: { maximum: 25 }, presence: true
  before_save { email.downcase! }
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  validates_uniqueness_of :email
  has_many :contacts
  has_many :notes
  has_many :projects, through: :contacts
  has_many :tasks
  acts_as_taggable_on :tags
end
