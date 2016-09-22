class Add < ActiveRecord::Migration
  def change
    add_column :comments, :source_id, :integer
    add_column :comments, :source_type, :string
  end
end
