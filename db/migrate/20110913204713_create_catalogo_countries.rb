class CreateCatalogoCountries < ActiveRecord::Migration
  def self.up
    create_table :catalogo_countries do |t|
      t.string :country

      #t.timestamps
    end
  end

  def self.down
    drop_table :catalogo_countries
  end
end
