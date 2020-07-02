require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe Attachment, type: :model do
  include CarrierWave::Test::Matchers

  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }
  
  it "has a valid factory" do
      # Parent model: Patient
      attachment = FactoryBot.build(:attachment, attachable_id: patient.id, attachable_type: "Patient")
      attachment.valid?
      # puts "Attachment: #{attachment.inspect}"
      expect(attachment).to be_valid
  end
  
  let (:attachment) { FactoryBot.create(:attachment, attachable_id: patient.id) }
  let (:pdf) { FactoryBot.create(:attachment, :pdf, attachable_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :attachable_id }
    it { is_expected.to validate_presence_of :attachable_type }
    it { is_expected.to validate_presence_of :fileattachment }

    it { expect(attachment).to allow_value('Patient').for(:attachable_type) }
    it { expect(attachment).to allow_value('Note').for(:attachable_type) }
    it { expect(attachment).to_not allow_value(nil).for(:name) }
    it { expect(attachment).to_not allow_value(nil).for(:attachable_id) }
    it { expect(attachment).to_not allow_value(nil).for(:attachable_type) }
    # FIXME
    xit { expect(attachment.fileattachment).to be_format('JPEG')}
    # it { expect(pdf.fileattachment).to be_format('pdf')}
    # TODO: REinstall ImageMagick in VM
    # https://stackoverflow.com/questions/30309633/after-replacing-rmagick-with-minimagick-gets-identify-im6-no-decode-delegate
    pending "Reinstall ImageMagick to support PDF in VM or migrate to ActiveStorage"
  end

  describe "Associations" do
    it { should belong_to(:attachable) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
