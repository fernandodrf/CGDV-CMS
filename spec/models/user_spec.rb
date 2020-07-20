# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(128)      default(""), not null
#  admin                  :boolean          default(FALSE)
#  language               :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  roles                  :string(255)      default("--- []")
#  volunteer_id           :integer
#  avatar                 :string(255)
#

require 'rails_helper'

RSpec.describe User, :users => true, type: :model do
  # Lazy loading of upper model
  let (:volunteer) { FactoryBot.create(:volunteer, :vol) }

  it "has a valid factory" do
    user = FactoryBot.build(:user, volunteer_id: volunteer.id)
    expect(user).to be_valid
    # puts "User: #{user.inspect}"
  end
  
  let (:user) { FactoryBot.create(:user, volunteer_id: volunteer.id) }
  describe "ActiveModel Validations" do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
    it { is_expected.to validate_presence_of :volunteer_id }
    
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    
    it { expect(user).to allow_value(Faker::Internet.email).for(:email) }
    # min password size is 8 characters
    it { expect(user).to_not allow_value('').for(:password) }
    pending "increase password min size to 8"
    it { expect(user).to_not allow_value(Faker::Internet.password(min_length: 4, max_length: 5)).for(:password) }
  end
end
