class Attachment < ActiveRecord::Base
	belongs_to :attachable, :polymorphic => true
  
  validates :attachable_id, :presence => true
  validates :attachable_type, :presence => true
  validates :name, :presence => true
  validates :fileattachment, :presence => true
	
	mount_uploader :fileattachment, FileattachmentUploader
end