class CreateRefclinicas < ActiveRecord::Migration
  def self.up
    create_table :refclinicas do |t|
      t.string :hospital
      t.string :medico
      t.date :referencia
      t.string :aceptado
      t.string :ayudas
      t.references :patient

      t.timestamps
    end
    add_index :refclinicas, :patient_id
  end

  def self.down
    drop_table :refclinicas
  end
end
