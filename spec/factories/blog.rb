FactoryBot.define do
  factory :blog do  
    title {"Title"}
    description {"New description"}
    
    user

    trait :with_photo do
      photo { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/test_pic.jpg", 'image/png') }
    end

    trait :with_link do
      link { "https://github.com/nibab-boo" }
    end
    # trait :with_user  do
    #   user
    # end
  end
end