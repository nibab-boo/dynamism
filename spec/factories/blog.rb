FactoryBot.define do
  factory :blog do
    title {"Title"}
    description {"New description"}
    
    user
    # trait :with_user  do
    #   user
    # end
  end
end