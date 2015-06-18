class Stage < ActiveRecord::Base
  validates :project_id, presence: true
  validates :name, presence: true, length: { maximum: 25 }
  belongs_to :project
  has_many :tasks, :as => :taskable
end
