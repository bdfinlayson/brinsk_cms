require 'faker'

FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.characters(20) }
    description { Faker::Hacker.say_something_smart }
    due { Time.now }
  end
end
