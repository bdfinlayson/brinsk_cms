require 'faker'

FactoryGirl.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company_name { Faker::Company.name }
    email { Faker::Internet.email }
    alt_email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    title { Faker::Name.title }
    background { Faker::Lorem.paragraph(2, false, 4) }
    first_met { Faker::Time.between(2.days.ago, Time.now, :all) }
  end
end
