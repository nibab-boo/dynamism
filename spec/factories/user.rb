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
  end
end