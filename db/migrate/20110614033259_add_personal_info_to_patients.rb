class AddPersonalInfoToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :sex, :string
    add_column :patients, :birthdate, :date
    add_column :patients, :blod, :string
  end

  def self.down
    remove_column :patients, :blod
    remove_column :patients, :birthdate
    remove_column :patients, :sex
  end
end
