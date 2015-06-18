class Appointment < ActiveRecord::Base
  belongs_to :appointable, polymorphic: true
end
