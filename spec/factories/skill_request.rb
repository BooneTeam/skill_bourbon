# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_request do
    title "MyString"
    subtitle "MyString"
    full_description "MyText"
    apprentice_level 1
    meeting_date_scheduled "2014-10-17 07:44:32"
    meeting_date_requested "2014-10-17 07:44:32"
    accepted_status "MyString"
    association :user
    location {|x| x.association(:location)}
    skill_level {|x| x.association(:skill_level)}
    has_apprenticeship true
  end
end
