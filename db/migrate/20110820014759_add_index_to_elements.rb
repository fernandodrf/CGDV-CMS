class AddIndexToElements < ActiveRecord::Migration
  def self.up
    add_index :elements, :note_id
  end

  def self.down
    remove_index :elements, :note_id
  end
end
