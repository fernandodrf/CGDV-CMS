# == Schema Information
# Schema version: 20110628183037
#
# Table name: catalogo_derechohabientes
#
#  id         :integer         not null, primary key
#  seguro     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CatalogoDerechohabiente < ActiveRecord::Base
  validates :seguro, :presence => true, :length => { :maximum => 50 }
end
