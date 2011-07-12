class Element < ActiveRecord::Base
  attr_accessible :codigo, :cantidad, :cuota, :descripcion
  belongs_to :note
  
  validates :codigo, :presence => true,:length => { :maximum => 250}
  validates :descripcion, :presence => true, :length => { :maximum => 250}
  validates :cantidad, :presence => true, :length => { :maximum => 20}, :numericality => true
  validates :cuota, :presence => true, :length => { :maximum => 20}, :numericality => true
  
end


# == Schema Information
#
# Table name: elements
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  cantidad    :integer
#  cuota       :decimal(22, 2)
#  descripcion :string(255)
#  note_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

