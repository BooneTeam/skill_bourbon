# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
    sequence(:request_description){|n| "Request Description#{n}"}
  factory :apprenticeship do
    request_description {generate(:request_description)}
    # meeting_date_scheduled "2014-10-17 07:43:38"
    meeting_date_requested Time.now + 2.days
    apprentice_accept_date false
    creator_accept_date false
    association :user
    skill {|x| x.association(:skill)}
    location {|x| x.association(:location)}
    skill_level {|x| x.association(:skill_level)}
  end

  trait :is_completed do
    completion_status "complete"
  end

  trait :is_accepted do
    accepted_status "confirmed"
  end

  trait :is_pending do
    accepted_status "pending"
  end

  trait :apprentice_has_accepted_date do
    apprentice_accept_date true
  end

  trait :creator_has_accepted_date do
    creator_accept_date true
  end

  trait :has_meeting_date_scheduled do
    meeting_date_scheduled Time.now + 3.days
  end
end
