class ChangeDailyscheduleTypeToInt < ActiveRecord::Migration
  def self.up	
    rename_column :dailyschedules, :day, :day_string
    add_column :dailyschedules, :day, :integer

    Dailyschedule.reset_column_information
    Dailyschedule.find_each { |c| c.update_attribute(:day, c.day_string) } 
    remove_column :dailyschedules, :day_string
  end

  def self.down
  	
    rename_column :dailyschedules, :day, :day_int
    add_column :dailyschedules, :day, :string

    Dailyschedule.reset_column_information
    Dailyschedule.find_each { |c| c.update_attribute(:day, c.day_int) } 
    remove_column :dailyschedules, :day_int
  end
end
