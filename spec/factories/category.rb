# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:title) { |n| "Category#{n}" }
  factory :category do
    name { generate(:title) }
    description "MyText"
  end
end
