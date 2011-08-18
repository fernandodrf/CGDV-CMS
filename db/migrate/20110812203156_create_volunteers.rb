class CreateVolunteers < ActiveRecord::Migration
  def self.up
    create_table :volunteers do |t|
      t.string :name
      t.integer :cgdvcode
      t.string :sex
      t.string :blood
      t.integer :status, :default => 1
      t.date :birth
      t.timestamps
    end
    add_index :volunteers, :cgdvcode, :unique => true
  end

  def self.down
    drop_table :volunteers
  end
end
