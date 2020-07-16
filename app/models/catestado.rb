# == Schema Information
#
# Table name: catestados
#
#  id         :integer          not null, primary key
#  estado     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Catestado < ApplicationRecord
end
