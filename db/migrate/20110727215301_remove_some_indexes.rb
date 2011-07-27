class RemoveSomeIndexes < ActiveRecord::Migration
  def self.up
  	remove_index :addresses, :patient_id
  	remove_index :apoyos, :patient_id
  	remove_index :comments, :patient_id
    remove_index :derechohabientes, :patient_id
    remove_index :diagnosticos, :patient_id
    remove_index :family_members, :patient_id
    remove_index :houses, :patient_id
    remove_index :patientphones, :patient_id
    remove_index :refclinicas, :patient_id
    remove_index :socioecos, :patient_id
    remove_index :tratamientos, :patient_id 
    remove_index :elements, :note_id  
  end

  def self.down
  	add_index :addresses, :patient_id
  	add_index :apoyos, :patient_id
  	add_index :comments, :patient_id
    add_index :derechohabientes, :patient_id
    add_index :diagnosticos, :patient_id
    add_index :family_members, :patient_id
    add_index :houses, :patient_id
    add_index :patientphones, :patient_id
    add_index :refclinicas, :patient_id
    add_index :socioecos, :patient_id
    add_index :tratamientos, :patient_id
    add_index :elements, :note_id
  end
end
