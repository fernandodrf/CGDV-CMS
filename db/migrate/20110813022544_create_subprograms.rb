class CreateSubprograms < ActiveRecord::Migration
  def self.up
    create_table :subprograms do |t|
      t.boolean :donador
      t.boolean :eventos
      t.boolean :hospitales
      t.boolean :suenosdeseos
      t.boolean :fondos
      t.boolean :administrativas
      t.boolean :autoayuda
      t.boolean :sobrevivientes
      t.boolean :fugarte
      t.references :volunteer

      t.timestamps
    end
  end

  def self.down
    drop_table :subprograms
  end
end
