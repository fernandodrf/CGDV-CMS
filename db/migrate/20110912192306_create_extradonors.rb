class CreateExtradonors < ActiveRecord::Migration
  def self.up
    create_table :extradonors do |t|
      t.string :pautoriza
      t.string :pcontacto
	  t.references :donor
      t.timestamps
    end
  end

  def self.down
    drop_table :extradonors
  end
end
