class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    # 既存のユーザはすべて管理者に
    User.update_all(role: 'admin')
  end
end
