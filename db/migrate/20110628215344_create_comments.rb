class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :comment
      t.references :patient

      t.timestamps
    end
    add_index :comments, :patient_id
  end

  def self.down
    drop_table :comments
  end
end
