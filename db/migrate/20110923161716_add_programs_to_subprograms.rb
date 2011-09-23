class AddProgramsToSubprograms < ActiveRecord::Migration
  def self.up
    add_column :subprograms, :disenografico, :boolean
    add_column :subprograms, :abogacia, :boolean
    add_column :subprograms, :invdocumental, :boolean
    add_column :subprograms, :invmedica, :boolean
    add_column :subprograms, :apoyofueraoficina, :boolean
  end

  def self.down
    remove_column :subprograms, :apoyofueraoficina
    remove_column :subprograms, :invmedica
    remove_column :subprograms, :invdocumental
    remove_column :subprograms, :abogacia
    remove_column :subprograms, :disenografico
  end
end
