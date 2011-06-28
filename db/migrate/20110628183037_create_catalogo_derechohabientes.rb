class CreateCatalogoDerechohabientes < ActiveRecord::Migration
  def self.up
    create_table :catalogo_derechohabientes do |t|
      t.string :seguro

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogo_derechohabientes
  end
end
