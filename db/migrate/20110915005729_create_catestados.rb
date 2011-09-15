class CreateCatestados < ActiveRecord::Migration
  def self.up
    create_table :catestados do |t|
      t.string :estado

      t.timestamps
    end
  end

  def self.down
    drop_table :catestados
  end
end
