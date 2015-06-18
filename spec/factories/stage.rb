require 'faker'

FactoryGirl.define do
  factory :stage do
    name { Faker::Hacker.noun }
  end
end
