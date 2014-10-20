# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "User#{n}@example.com" }
  sequence(:username) { |n| "User#{n}" }
  sequence(:password) { |n| "UserPassword#{n}" }

  factory :user do |f|
    f.email {generate(:email) }
    f.username {generate(:username)}
    f.password {generate(:password)}
  end

end
