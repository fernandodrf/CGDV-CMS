# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  comment          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  commentable_type :string(255)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }
  
  it "has a valid factory" do
      comment = FactoryBot.build(:comment, commentable_id: patient.id)
      comment.valid?
      # puts "Comment: #{comment.inspect}"
      expect(comment).to be_valid
  end
  
  let (:comment) { FactoryBot.create(:comment, commentable_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :comment }
    it { is_expected.to validate_presence_of :commentable_id }
    it { is_expected.to validate_presence_of :commentable_type }
    it { is_expected.to validate_length_of(:comment).is_at_least(1) }
    # FIXME
    xit { is_expected.to validate_length_of(:comment).is_at_most(200) }
    pending "Eliminate range limit"

    it { expect(comment).to allow_value('Patient').for(:commentable_type) }
    it { expect(comment).to_not allow_value(nil).for(:comment) }
    it { expect(comment).to allow_value('Comentario bla blo blo ble bli áéí').for(:comment) }
    it { expect(comment).to_not allow_value(nil).for(:commentable_id) }
    it { expect(comment).to_not allow_value(nil).for(:commentable_type) }
  end

  describe "Associations" do
    it { should belong_to(:commentable) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
