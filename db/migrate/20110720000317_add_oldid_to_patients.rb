class AddOldidToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :oldid, :string
  end

  def self.down
    remove_column :patients, :oldid
  end
end
