class CreateExtravolunteers < ActiveRecord::Migration
  def self.up
    create_table :extravolunteers do |t|
      t.string :profesion
      t.boolean :sobreviviente
      t.boolean :licencia
      t.boolean :exposferias
      t.references :volunteer
      
      t.timestamps
    end
  end

  def self.down
    drop_table :extravolunteers
  end
end
