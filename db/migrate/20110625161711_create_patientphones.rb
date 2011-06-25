class CreatePatientphones < ActiveRecord::Migration
  def self.up
    create_table :patientphones do |t|
      t.string :place
      t.string :number
      t.references :patient

      t.timestamps
    end
    add_index :patientphones, :patient_id
  end

  def self.down
    drop_table :patientphones
  end
end
