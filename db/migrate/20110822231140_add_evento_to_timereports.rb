class AddEventoToTimereports < ActiveRecord::Migration
  def self.up
    add_column :timereports, :evento, :string
  end

  def self.down
    remove_column :timereports, :evento
  end
end
