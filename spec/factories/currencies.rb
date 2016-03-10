# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :currency do
    name { Faker::Name.name }
    converter { Faker::Number.decimal(2, 3) }
    code "XYZ"
    buy_price { Faker::Number.decimal(2, 3) }
    sell_price { Faker::Number.decimal(2, 3) }
  end
end
