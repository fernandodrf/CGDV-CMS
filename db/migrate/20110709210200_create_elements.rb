class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.string :codigo
      t.integer :cantidad
      t.decimal :cuota, :precision => 22, :scale => 2
      t.string :descripcion
      t.references :note

      t.timestamps
    end
    add_index :elements, :note_id  
  end

  def self.down
    drop_table :elements
  end
end
