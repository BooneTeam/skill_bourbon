# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "User#{n}@example.com" }
  sequence(:username) { |n| "User#{n}" }
  sequence(:password) { |n| "UserPassword#{n}" }

  factory :user do |f|
    f.email {generate(:email) }
    f.username {generate(:username)}
    f.password {generate(:password)}

    factory :user_with_inactive_skills do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        skills_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list(:skill, evaluator.skills_count, creator: user)
      end
    end

    factory :user_with_active_skills do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        skills_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list((:active_skill), evaluator.skills_count, creator: user)
      end
    end


    factory :user_with_skill_requests do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        skill_requests_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list(:skill_request, evaluator.skill_requests_count, user: user)
      end
    end
  end



end
