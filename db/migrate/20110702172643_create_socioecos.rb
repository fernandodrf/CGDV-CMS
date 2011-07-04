class CreateSocioecos < ActiveRecord::Migration
  def self.up
    create_table :socioecos do |t|
      t.integer :ingresos
      t.integer :gastos
      t.integer :televisiones
      t.integer :vehiculos
      t.string :nivel
      t.string :serviciosurbanos
      t.string :televisionpaga
      t.string :sgmm
      t.references :patient

      t.timestamps
    end
    add_index :socioecos, :patient_id    
  end

  def self.down
    drop_table :socioecos
  end
end
