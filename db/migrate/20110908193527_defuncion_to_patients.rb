class DefuncionToPatients < ActiveRecord::Migration
  def self.up
  	add_column :patients, :fdefuncion, :date
  	add_column :patients, :faviso, :date
  	add_column :patients, :montocon, :string
  end

  def self.down
  	remove_column :patients, :fdefuncion
  	remove_column :patients, :faviso
  	remove_column :patients, :montocon
  end
end
