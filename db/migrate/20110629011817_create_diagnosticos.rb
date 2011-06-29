class CreateDiagnosticos < ActiveRecord::Migration
  def self.up
    create_table :diagnosticos do |t|
      t.string :diagnostico
      t.references :patient

      t.timestamps
    end
    add_index :diagnosticos, :patient_id
  end

  def self.down
    drop_table :diagnosticos
  end
end
