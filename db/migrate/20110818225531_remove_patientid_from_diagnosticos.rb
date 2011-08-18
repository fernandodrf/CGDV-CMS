class RemovePatientidFromDiagnosticos < ActiveRecord::Migration
  def self.up
  	remove_column :diagnosticos, :patient_id
  end

  def self.down
  	add_column :diagnosticos, :patient_id, :integer
  end
end
