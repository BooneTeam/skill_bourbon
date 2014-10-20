# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :apprenticeship do
    request_description "MyText"
    completion_status "MyString"
    accepted_status "MyString"
    apprentice_level 1
    meeting_date_scheduled "2014-10-17 07:43:38"
    meeting_date_requested "2014-10-17 07:43:38"
    apprentice_accept_date false
    creator_accept_date false

    association :user
    skill {|x| x.association(:skill)}
    location {|x| x.association(:location)}
    skill_level {|x| x.association(:skill_level)}
  end
end
