class CreateDerechohabientes < ActiveRecord::Migration
  def self.up
    create_table :derechohabientes do |t|
      t.string :seguro
      t.string :afiliacion
      t.references :patient

      t.timestamps
    end
    add_index :derechohabientes, :patient_id
  end

  def self.down
    drop_table :derechohabientes
  end
end
