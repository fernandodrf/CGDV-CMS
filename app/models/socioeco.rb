# == Schema Information
#
# Table name: socioecos
#
#  id               :integer          not null, primary key
#  ingresos         :integer
#  gastos           :integer
#  televisiones     :integer
#  vehiculos        :integer
#  nivel            :string(255)
#  serviciosurbanos :string(255)
#  televisionpaga   :string(255)
#  sgmm             :string(255)
#  patient_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Socioeco < ActiveRecord::Base
  belongs_to :patient

  validates :patient_id, :presence => true
  validates :ingresos, :presence => true, :length => { :maximum => 10},	:numericality => true
  validates :gastos, :presence => true,	:length => { :maximum => 10}, :numericality => true
  validates :televisiones, :presence => true, :length => { :maximum => 10},	:numericality => true
  validates :vehiculos, :presence => true, :length => { :maximum => 10}, :numericality => true
  validates :nivel, :presence => true, :length => { :maximum => 50}
  validates :serviciosurbanos, :presence => true, :length => { :maximum => 50}
  validates :televisionpaga, :presence => true, :length => { :maximum => 50}
  validates :sgmm, :presence => true, :length => { :maximum => 50}
end
