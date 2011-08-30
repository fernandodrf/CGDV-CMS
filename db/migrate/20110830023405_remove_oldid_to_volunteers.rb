class RemoveOldidToVolunteers < ActiveRecord::Migration
  def self.up
  	remove_column :volunteers, :oldid
  end

  def self.down
    add_column :volunteers, :oldid, :string
  end
end
