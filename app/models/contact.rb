class Contact < ActiveRecord::Base
  belongs_to :user
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 25 }

end
