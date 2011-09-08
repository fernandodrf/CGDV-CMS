class AddEasyRolesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :roles, :string, :default => "--- []"
    User.find_each { |u| u.update_attribute(:roles, []) } 
  end

  def self.down
    remove_column :users, :roles
  end
end
