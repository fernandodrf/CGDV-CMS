class CreateFamilyMembers < ActiveRecord::Migration
  def self.up
    create_table :family_members do |t|
      t.string :parentesco
      t.string :nombre
      t.integer :edad
      t.string :derechohabiente
      t.string :comentarios
      t.references :patient

      t.timestamps
    end
    add_index :family_members, :patient_id  
  end

  def self.down
    drop_table :family_members
  end
end
