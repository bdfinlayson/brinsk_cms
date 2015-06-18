require 'faker'

FactoryGirl.define do
  factory :project do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(2, false, 4) }
    start_date { Faker::Time.between(2.days.ago, Time.now, :all) }
    end_date { Faker::Time.forward(23, :morning) }
    completed false
  end

end
