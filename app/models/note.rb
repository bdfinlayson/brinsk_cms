class Note < ActiveRecord::Base
  attr_accessor :subject, :content, :tag_list
  validates :contact_id, presence: true
  validates :user_id, presence: true
  validates :subject, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  belongs_to :user
  belongs_to :project
  belongs_to :contact
  acts_as_taggable


end
