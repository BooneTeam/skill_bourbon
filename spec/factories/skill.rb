# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    association :creator, factory: [:user]
    # creator_type "User"
    association :skill_level, factory: [:skill_level]
    association :location, factory: [:location]
    categories [FactoryGirl.build(:category)]

    title "MyString"
    subtitle "MyString"
    full_description "MyText"
    is_active false
    price "9.99"
  end

  # factory :valid_skill, :parent => :user do
    # categories {[FactoryGirl.create(:category)]}
  # end

end
