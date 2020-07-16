# == Schema Information
#
# Table name: refclinicas
#
#  id         :integer          not null, primary key
#  hospital   :string(255)
#  medico     :string(255)
#  referencia :date
#  aceptado   :string(255)
#  ayudas     :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Refclinica < ApplicationRecord
  belongs_to :patient

  validates :patient_id, :presence => true
  validates :hospital, :presence => true, :length => { :maximum => 50}
  validates :medico, :presence => true, :length => { :maximum => 250}
  validates :referencia, :presence => true
  validates :aceptado, :presence => true, :length => { :maximum => 250}
  validates :ayudas, :presence => true, :length => { :maximum => 250}
end
