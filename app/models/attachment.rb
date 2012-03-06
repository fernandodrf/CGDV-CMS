class Attachment < ActiveRecord::Base
	
	belongs_to :attachable, :polymorphic => true
  
  validates :attachable_id, :presence => true
  validates :attachable_type, :presence => true
  validates :name, :presence => true
  validates :fileattachment, :presence => true
	
	mount_uploader :fileattachment, FileattachmentUploader
end

# == Schema Information
#
# Table name: attachments
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  fileattachment  :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

