class Note < ActiveRecord::Base
  validates :subject, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  belongs_to :user
  belongs_to :project
  belongs_to :contact
  acts_as_taggable

  searchable do
    text :subject, :content
    time :created_at
    time :updated_at
  end


end
