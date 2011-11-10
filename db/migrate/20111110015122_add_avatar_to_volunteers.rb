class AddAvatarToVolunteers < ActiveRecord::Migration
  def change
    add_column :volunteers, :avatar, :string
  end
end
