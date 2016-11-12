class Note < ActiveRecord::Base
  validates :subject, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  belongs_to :user
  belongs_to :project
  belongs_to :contact
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings, as: :taggable

  def self.search(search)
    if search
      where('subject like ? or content like ?', "%#{search}%", "%#{search}%")
    else
      []
    end
  end


end
