class Contact < ActiveRecord::Base
  before_save :generate_auth_token

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
  has_many :goals
  has_many :retrospectives
  scope :lead_team, -> { where(lead_team: true) }

  def generate_auth_token
    if self.changes[:lead_team].try(:last)
      self.auth_token = SecureRandom.base58(48)
    else
      self.auth_token = nil
    end
  end

  def has_submitted_weekly_status_update?
    retrospectives.where(created_at: Time.now.beginning_of_week...Time.now.end_of_week).any?
  end

  def full_address
    "#{street1}, #{street2 unless blank?}, #{city}, #{state} #{zipcode}"
  end
  alias_method :address, :full_address

  def full_name
    "#{first_name} #{last_name}"
  end

  def send_status_update_request
    next if has_submitted_weekly_status_update?

    lead_email = self.user.email
    developer_email = email

    data = { "to" => { developer_email => full_name },
      "from" => [lead_email],
      "replyto" => [lead_email],
      "subject" => "Weekly Developer Status Update",
      "text" => "Hi, #{first_name}. Please give me a short update on what you've done this week and how you're progressing on your goals no later than noon Friday. Thanks so much! #{Rails.application.routes.url_helpers.new_retrospective_url(host: 'brinsk.herokuapp.com', auth_token: developer.auth_token)}",
      "headers" => {"Content-Type"=> "text/html;charset=iso-8859-1"}
    }

    result = m.send_email(data)
    puts result
  end
end
