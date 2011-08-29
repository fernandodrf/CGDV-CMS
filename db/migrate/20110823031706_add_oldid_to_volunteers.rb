class AddOldidToVolunteers < ActiveRecord::Migration
  def self.up
    add_column :volunteers, :oldid, :string
  end

  def self.down
    remove_column :volunteers, :oldid
  end
end
