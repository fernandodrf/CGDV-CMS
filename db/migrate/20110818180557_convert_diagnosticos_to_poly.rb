class ConvertDiagnosticosToPoly < ActiveRecord::Migration
  def self.up
    change_table :diagnosticos do |t|
      t.references :diagnosticable, :polymorphic => true
    end
  end

  def self.down
    remove_column :diagnosticos, :diagnosticable_id
    remove_column :diagnosticos, :diagnosticable_type
  end
end
