class AddStatusToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :status, :integer, :default => 1
  end

  def self.down
    remove_column :patients, :status
  end
end
