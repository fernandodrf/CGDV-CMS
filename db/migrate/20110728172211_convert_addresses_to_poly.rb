class ConvertAddressesToPoly < ActiveRecord::Migration
  def self.up
    change_table :addresses do |t|
      t.references :addresseable, :polymorphic => true
    end
  end

  def self.down
    remove_column :addresses, :addresseable_id
    remove_column :addresses, :addresseable_type
  end
end
