class AddClickTimesToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :click_times, :integer, null: false, default: 0
  end
end
