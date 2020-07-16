# == Schema Information
#
# Table name: telephones
#
#  id                 :integer          not null, primary key
#  place              :string(255)
#  number             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  telephoneable_id   :integer
#  telephoneable_type :string(255)
#

class Telephone < ApplicationRecord 
  belongs_to :telephoneable, :polymorphic => true

  validates :place, :presence => true, :length => { :maximum => 50 }
  validates :number, :presence => true, :length => { :maximum => 50 }
  validates :telephoneable_id, :presence => true
  validates :telephoneable_type, :presence => true
end
