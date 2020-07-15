# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  fileattachment  :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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
