class Telephone < ActiveRecord::Base
  attr_accessible :place, :number
  
  belongs_to :telephoneable, :polymorphic => true

  validates :place, :presence => true, :length => { :maximum => 50 }
  validates :number, :presence => true, :length => { :maximum => 50 }
  validates :telephoneable_id, :presence => true
  validates :telephoneable_type, :presence => true
  
end


# == Schema Information
#
# Table name: telephones
#
#  id                 :integer         not null, primary key
#  place              :string(255)
#  number             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  telephoneable_id   :integer
#  telephoneable_type :string(255)
#

