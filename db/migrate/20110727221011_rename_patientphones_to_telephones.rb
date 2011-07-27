class RenamePatientphonesToTelephones < ActiveRecord::Migration
  def self.up
  	rename_table :patientphones, :telephones
  end

  def self.down
  	rename_table :telephones, :patientphones
  end
end
