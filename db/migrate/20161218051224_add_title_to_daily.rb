class AddTitleToDaily < ActiveRecord::Migration
  def change
    add_column :dailies, :title, :string
    add_column :dailies, :spec_type, :integer, default: 1
  end
end
