class ConvertTelephonesToPoly < ActiveRecord::Migration
  def self.up
    change_table :telephones do |t|
      t.references :telephoneable, :polymorphic => true
    end
  end

  def self.down
    remove_column :telephones, :telephoneable_id
    remove_column :telephones, :telephoneable_type
  end
end
