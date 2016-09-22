class ChangeComment < ActiveRecord::Migration
  def change
    remove_column :comments, :source_type, :string
    add_column :comments, :blog_id, :string
  end
end
