# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_request do
    title "MyString"
    subtitle "MyString"
    full_description "MyText"
    # meeting_date_scheduled "2014-10-17 07:44:32"
    meeting_date_requested "2014-10-17 07:44:32"
    # accepted_status "MyString"
    association :user
    location {|x| x.association(:location)}
    skill_level {|x| x.association(:skill_level)}
    # has_apprenticeship true
  end

  trait :has_apprenticeship do
    has_apprenticeship true
  end

  trait :has_scheduled_date do
    meeting_date_scheduled Time.now + 2.days
  end

  #is_accepted is already defined in apprenticeship
end
