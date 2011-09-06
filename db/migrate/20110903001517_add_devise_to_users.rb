class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      #t.database_authenticatable :null => false
      t.change :encrypted_password, :string, { :null => false, :default => '', :limit => 128 }
      #creates reset_password_token
      t.recoverable
      t.rememberable
      t.trackable
    
      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

    end

    #add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    
    raise ActiveRecord::IrreversibleMigration
    remove_column :users, :recoverable
    remove_column :users, :rememberable
    remove_column :users, :trackable
    remove_index :users, :reset_password_token
  end
end
