class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :session_id
      t.datetime :expired_at

      t.timestamps null: false
    end
    remove_column :users, :session_id
    remove_column :users, :expired_at
  end
end
