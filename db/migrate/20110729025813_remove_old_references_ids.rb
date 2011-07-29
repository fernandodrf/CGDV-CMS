class RemoveOldReferencesIds < ActiveRecord::Migration
  def self.up
  	remove_column :comments, :patient_id
  	remove_column :telephones, :patient_id
  	remove_column :addresses, :patient_id
  	remove_column :patients, :oldid
  end

  def self.down
    add_column :comments, :patient_id, :integer
  	add_column :telephones, :patient_id, :integer
  	add_column :addresses, :patient_id, :integer
  	add_column :patients, :oldid, :string
  end
end
