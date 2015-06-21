require 'faker'

FactoryGirl.define do
  factory :stage do
    name { Faker::Number.number(3) }
  end
end
