# == Schema Information
#
# Table name: subprograms
#
#  id                :integer          not null, primary key
#  donador           :boolean
#  eventos           :boolean
#  hospitales        :boolean
#  suenosdeseos      :boolean
#  fondos            :boolean
#  administrativas   :boolean
#  autoayuda         :boolean
#  sobrevivientes    :boolean
#  fugarte           :boolean
#  volunteer_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  sobreviviente     :boolean
#  licencia          :boolean
#  exposferias       :boolean
#  disenografico     :boolean
#  abogacia          :boolean
#  invdocumental     :boolean
#  invmedica         :boolean
#  apoyofueraoficina :boolean
#  disenoweb         :boolean
#  apoyocap          :boolean
#

class Subprogram < ApplicationRecord    
  belongs_to :volunteer
end
