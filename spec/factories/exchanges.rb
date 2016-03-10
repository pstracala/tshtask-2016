# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :exchange do
    name { Faker::Name.name }
  end
end
