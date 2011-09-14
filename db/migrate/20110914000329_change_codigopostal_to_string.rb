class ChangeCodigopostalToString < ActiveRecord::Migration
  def self.up	
    rename_column :addresses, :codigopostal, :codigopostal_integer
    add_column :addresses, :codigopostal, :string

    Address.reset_column_information
    Address.find_each { |c| c.update_attribute(:codigopostal, c.codigopostal_integer) } 
    remove_column :addresses, :codigopostal_integer
  end

  def self.down
  	
    rename_column :addresses, :codigopostal, :codigopostal_string
    add_column :addresses, :codigopostal, :integer

    Address.reset_column_information
    Address.find_each { |c| c.update_attribute(:codigopostal, c.codigopostal_string) } 
    remove_column :addresses, :codigopostal_string
  end
end
