class CreateVolTimes < ActiveRecord::Migration
  def self.up
    create_table :vol_times do |t|
      t.string :evento
      t.integer :horas
      t.references :volunteer

      t.timestamps
    end
    add_index :vol_times, :volunteer_id
  end

  def self.down
    drop_table :vol_times
  end
end
