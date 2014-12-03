# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:skill_title) { |n| "TItle#{n}" }
  sequence(:skill_subtitle) { |n| "Subtitle#{n}" }
  sequence(:skill_full_description) { |n| "Full Description#{n}" }
  sequence(:skill_price) { |n| "#{n}.00" }
  factory :skill do
    # association :author, :factory => :user, :username => 'admin'
    association :creator, :factory => :user
    association :skill_level, factory: [:skill_level]
    association :location, factory: [:location]
    categories [FactoryGirl.build(:category)]
    title {generate(:skill_title)}
    subtitle {generate(:skill_subtitle)}
    full_description {generate(:skill_full_description)}
    price {generate(:skill_price)}

    factory :active_skill do
      is_active true
    end
  end



  # factory :valid_skill, :parent => :user do
    # categories {[FactoryGirl.create(:category)]}
  # end

end
