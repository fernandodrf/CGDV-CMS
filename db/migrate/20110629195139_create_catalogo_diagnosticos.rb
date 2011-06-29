class CreateCatalogoDiagnosticos < ActiveRecord::Migration
  def self.up
    create_table :catalogo_diagnosticos do |t|
      t.string :diagnostico

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogo_diagnosticos
  end
end
