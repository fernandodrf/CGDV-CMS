class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
	  t.integer :cgdvcode
      t.integer :persona
      t.string :name
      t.string :rfc
      t.date :birth
      t.timestamps
    end
	add_index :donors, :cgdvcode, :unique => true    
  end

  def self.down
    drop_table :donors
  end
end
