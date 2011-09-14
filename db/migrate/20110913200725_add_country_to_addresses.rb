class AddCountryToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :country, :integer, :default => 1
    Address.reset_column_information
    Address.find_each { |c| c.update_attribute(:country, 1) } 
  end

  def self.down
    remove_column :addresses, :country
  end
end
