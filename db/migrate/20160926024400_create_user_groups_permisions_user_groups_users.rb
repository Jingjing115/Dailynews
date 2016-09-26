class CreateUserGroupsPermisionsUserGroupsUsers < ActiveRecord::Migration
  def change
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
