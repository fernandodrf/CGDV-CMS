class ConvertCommentsToPoly < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.references :commentable, :polymorphic => true
    end
  end



  def self.down
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type
  end
end
