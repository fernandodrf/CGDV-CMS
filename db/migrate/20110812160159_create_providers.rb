class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string :proveedor
      t.integer :cgdvcode
      t.string :name

      t.timestamps
    end
    add_index :providers, :cgdvcode, :unique => true
  end

  def self.down
    drop_table :providers
  end
end
