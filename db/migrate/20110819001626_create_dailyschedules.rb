class CreateDailyschedules < ActiveRecord::Migration
  def self.up
    create_table :dailyschedules do |t|
      t.string :day
      t.time :begin
      t.time :end
      t.references :volunteer

      t.timestamps
    end
  end

  def self.down
    drop_table :dailyschedules
  end
end
