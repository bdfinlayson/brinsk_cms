require 'faker'

FactoryGirl.define do
  factory :task do
    name { Faker::Hacker.noun }
    description { Faker::Hacker.say_something_smart }
    due { Time.now }
  end
end
