class AddDatosToEmails < ActiveRecord::Migration
  def self.up
    add_column :emails, :datos, :string
  end

  def self.down
    remove_column :emails, :datos
  end
end
