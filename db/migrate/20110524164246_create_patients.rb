class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :name
      t.integer :cgdvcode

      t.timestamps
    end
    add_index :patients, :cgdvcode, :unique => true
  end

  def self.down
    drop_table :patients
  end
end
