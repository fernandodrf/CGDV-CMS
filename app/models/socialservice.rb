class Socialservice < ActiveRecord::Base
  attr_accessible :horas, :escuela, :carrera, :matricula, :semestre, :inicio, :fin
  belongs_to :volunteer
end

# == Schema Information
#
# Table name: socialservices
#
#  id           :integer         not null, primary key
#  horas        :string(255)
#  escuela      :string(255)
#  carrera      :string(255)
#  matricula    :string(255)
#  semestre     :string(255)
#  inicio       :date
#  fin          :date
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

