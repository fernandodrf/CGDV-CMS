class CreateHouses < ActiveRecord::Migration
  def self.up
    create_table :houses do |t|
      t.integer :habitaciones
      t.string :tipo
      t.integer :habitantes
      t.integer :familiares
      t.integer :menores
      t.integer :economicaactivas
      t.references :patient

      t.timestamps
    end
    add_index :houses, :patient_id
  end

  def self.down
    drop_table :houses
  end
end
