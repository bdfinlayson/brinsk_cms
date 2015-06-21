require 'faker'

FactoryGirl.define do
  factory :appointment do
    starts_at { Time.now }
    description { Faker::Lorem.paragraph(2) }
    street1 { Faker::Address.street_address }
    street2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
    full_address { "#{Faker::Address.street_address},
                   #{Faker::Address.secondary_address},
                   #{Faker::Address.city}, #{Faker::Address.state_abbr} #{Faker::Address.zip_code}" }
  end
end
