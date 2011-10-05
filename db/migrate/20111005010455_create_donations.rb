class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.integer :folio
      t.references :donor
      t.date :frecepcion
      t.integer :tipo
      t.string :monto
      t.string :transaccion
      t.string :finalidad
      t.integer :motivo
      t.timestamps
    end
    add_index :donations, :donor_id
  end

  def self.down
    drop_table :donations
  end
end
