class CreateTratamientos < ActiveRecord::Migration
  def self.up
    create_table :tratamientos do |t|
      t.string :tipo
      t.references :patient

      t.timestamps
    end
    add_index :tratamientos, :patient_id
  end

  def self.down
    drop_table :tratamientos
  end
end
