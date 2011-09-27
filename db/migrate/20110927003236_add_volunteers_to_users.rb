class AddVolunteersToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :volunteer_id, :integer
  end

  def self.down
    remove_column :users, :volunteer_id
  end
end
