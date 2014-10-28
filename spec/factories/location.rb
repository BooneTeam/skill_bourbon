# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    address "MyString"
    city "MyString"
    state "MyString"
    zip 79932
  end
end
