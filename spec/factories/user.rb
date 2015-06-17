require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password 'password'
    password_confirmation 'password'
  end

  factory :user_contact do
    user
    contact
    deleted_at nil
    updated_at { FactoryGirl.generate(:time) }
    created_at { FactoryGirl.generate(:time) }
  end
end
