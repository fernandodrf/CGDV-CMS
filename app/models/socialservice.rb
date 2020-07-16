# == Schema Information
#
# Table name: socialservices
#
#  id           :integer          not null, primary key
#  escuela      :string(255)
#  carrera      :string(255)
#  matricula    :string(255)
#  semestre     :string(255)
#  inicio       :date
#  fin          :date
#  volunteer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Socialservice < ApplicationRecord
  belongs_to :volunteer
end
