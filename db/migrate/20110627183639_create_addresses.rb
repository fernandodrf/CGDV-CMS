class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :place
      t.integer :codigopostal
      t.string :estado
      t.string :municipio
      t.string :colonia
      t.string :domicilio
      t.references :patient

      t.timestamps
    end
      add_index :addresses, :patient_id
  end

  def self.down
    drop_table :addresses
  end
end
