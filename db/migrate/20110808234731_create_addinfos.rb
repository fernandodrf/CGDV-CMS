class CreateAddinfos < ActiveRecord::Migration
  def self.up
    create_table :addinfos do |t|
      t.integer :tipo
      t.string :info
      t.references :addinformation, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :addinfos
  end
end
