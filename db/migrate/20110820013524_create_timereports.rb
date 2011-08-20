class CreateTimereports < ActiveRecord::Migration
  def self.up
    create_table :timereports do |t|
      t.date :day
      t.time :begin
      t.time :end
      t.references :volunteer

      t.timestamps
    end
    add_index :timereports, :volunteer_id
  end

  def self.down
    drop_table :timereports
  end
end
