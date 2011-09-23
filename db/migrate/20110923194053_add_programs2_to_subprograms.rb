class AddPrograms2ToSubprograms < ActiveRecord::Migration
  def self.up
    add_column :subprograms, :disenoweb, :boolean
    add_column :subprograms, :apoyocap, :boolean
  end

  def self.down
    remove_column :subprograms, :apoyocap
    remove_column :subprograms, :disenoweb
  end
end
