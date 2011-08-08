require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  company    :string(255)
#  position   :string(255)
#  birth      :date
#  created_at :datetime
#  updated_at :datetime
#

