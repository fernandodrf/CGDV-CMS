class Subprogram < ActiveRecord::Base
  attr_accessible :donador, :eventos, :hospitales, :suenosdeseos, :fondos, :administrativas, :autoayuda, :sobrevivientes, :fugarte
  
  belongs_to :volunteer
  
end

# == Schema Information
#
# Table name: subprograms
#
#  id              :integer         not null, primary key
#  donador         :boolean
#  eventos         :boolean
#  hospitales      :boolean
#  suenosdeseos    :boolean
#  fondos          :boolean
#  administrativas :boolean
#  autoayuda       :boolean
#  sobrevivientes  :boolean
#  fugarte         :boolean
#  volunteer_id    :integer
#  created_at      :datetime
#  updated_at      :datetime
#

