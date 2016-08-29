class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id, :null => false
      t.string :title, :null => false
      t.text :content, :null => false

      t.timestamps null: false
    end
  end
end
