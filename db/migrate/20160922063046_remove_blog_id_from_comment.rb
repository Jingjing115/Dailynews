class RemoveBlogIdFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :blog_id, :integer
  end
end
