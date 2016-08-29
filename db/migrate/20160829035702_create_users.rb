class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password, :null => false
      t.string :name, :null => false
      t.string :session_id
      t.datetime :expired_at

      t.timestamps null: false
    end
    add_index :users, :name, :unique => true
  end
end
