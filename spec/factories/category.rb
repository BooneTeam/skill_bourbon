# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:category_title) { |n| "Category#{n}" }
  sequence(:category_description) { |n| "CategoryDescription#{n}" }
  factory :category do
    name { generate(:category_title) }
    description {generate(:category_description)}
  end
end
