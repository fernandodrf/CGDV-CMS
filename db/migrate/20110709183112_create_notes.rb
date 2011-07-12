class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :folio
      t.decimal :adeudo, :precision => 22, :scale => 2
      t.decimal :acuenta, :precision => 22, :scale => 2
      t.decimal :restan, :precision => 22, :scale => 2
      t.decimal :subtotal, :precision => 22, :scale => 2
      t.decimal :total, :precision => 22, :scale => 2
      t.date :fecha
      t.references :patient

      t.timestamps
    end
    add_index :notes, :patient_id  
    add_index :notes, :folio, :unique => true
  end

  def self.down
    drop_table :notes
  end
end
