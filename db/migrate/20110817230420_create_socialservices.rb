class CreateSocialservices < ActiveRecord::Migration
  def self.up
    create_table :socialservices do |t|
      t.string :horas
      t.string :escuela
      t.string :carrera
      t.string :matricula
      t.string :semestre
      t.date :inicio
      t.date :fin
      t.references :volunteer

      t.timestamps
    end
  end

  def self.down
    drop_table :socialservices
  end
end
