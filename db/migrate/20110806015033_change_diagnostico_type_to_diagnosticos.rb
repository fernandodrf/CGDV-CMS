class ChangeDiagnosticoTypeToDiagnosticos < ActiveRecord::Migration
  def self.up
  	
    rename_column :diagnosticos, :diagnostico, :diagnostico_string
    add_column :diagnosticos, :diagnostico, :integer

    Diagnostico.reset_column_information
    Diagnostico.find_each { |c| c.update_attribute(:diagnostico, c.diagnostico_string) } 
    remove_column :diagnosticos, :diagnostico_string
  end

  def self.down
  	
    rename_column :diagnosticos, :diagnostico, :diagnostico_int
    add_column :diagnosticos, :diagnostico, :string

    Diagnostico.reset_column_information
    Diagnostico.find_each { |c| c.update_attribute(:diagnostico, c.diagnostico_int) } 
    remove_column :diagnosticos, :diagnostico_int
  end
end
