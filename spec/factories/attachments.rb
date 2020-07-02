FactoryBot.define do
  factory :attachment do
    attachable_id { 1 }
    attachable_type { "Patient" }
    name { "cartoon" }
    # Example for carrierwave attachment: https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Use-test-factories
    # logo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/logo_image.jpg'), 'image/jpeg') }
    fileattachment { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/test_01.jpg')) }
    
    trait :pdf do
      fileattachment { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/test_01.pdf')) }
    end    
  end
end
