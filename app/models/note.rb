class Note < ActiveRecord::Base
  validates :contact_id, presence: true
  validates :user_id, presence: true
  validates :subject, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  belongs_to :user
  belongs_to :contact


end
