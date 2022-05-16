FactoryBot.define do
  factory :user do
    email { "test1@gmail.com" }
    password  { "password" }
    confirmed_at { 2.days.ago }
    created_at { 3.days.ago }
    
    trait :with_domain do
      domain { "www.test.com" }
    end

    trait :production do
      test { false }
    end

    factory :user_with_blogs do
      transient do
        blogs_count { 2 }
      end

      after(:create) do |user, evaluator|
        create_list(:blog, evaluator.blogs_count, user: user)
        # might need to comment this depending upon code.
        user.reload
      end
    end

  end
end