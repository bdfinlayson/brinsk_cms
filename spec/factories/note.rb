require 'faker'

FactoryGirl.define do
  factory :note do
    subject { Faker::Lorem.characters(25) }
    content { Faker::Lorem.paragraph(2, false, 4) }
  end

end
