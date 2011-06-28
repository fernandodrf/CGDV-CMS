class CreateApoyos < ActiveRecord::Migration
  def self.up
    create_table :apoyos do |t|
      t.string :tipo
      t.references :patient

      t.timestamps
    end
    add_index :apoyos, :patient_id
  end

  def self.down
    drop_table :apoyos
  end
end
