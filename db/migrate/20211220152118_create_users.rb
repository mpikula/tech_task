class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_hash, null: false
      
      t.integer :login_attempts, default: 0
      t.boolean :account_locked, default: false
    
      t.timestamps
    end
  end
end