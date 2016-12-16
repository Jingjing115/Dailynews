class Migrate < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id, :null => false
      t.string :title, :null => false
      t.text :content, :null => false
      t.integer :click_times, :null => false, default: 0
      t.timestamps null: false
    end

    create_table :comments do |t|
      t.integer :user_id
      t.integer :blog_id
      t.text :content, :null => false
      t.integer :source_id

      t.timestamps null: false
    end

    create_table :sessions do |t|
      t.integer :user_id
      t.string :session_id
      t.datetime :expired_at
      t.string :user_agent
      t.timestamps null: false
    end

    create_table :dailies do |t|
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end

    create_table :permissions do |t|
      t.string :description
      t.string :code
      t.string :name

      t.timestamps null: false
    end

    create_table :user_groups do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end

    create_table :permissions_user_groups do |t|
      t.integer :user_group_id
      t.integer :permission_id
    end
    create_table :user_groups_users do |t|
      t.integer :user_id
      t.integer :user_group_id
    end
  end
end
