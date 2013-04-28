class AddPriorityToPages < ActiveRecord::Migration
  def up
    add_column :pages, :priority, :float
    Page.update_all('priority = 0.5')
  end

  def down
    remove_column :pages, :priority
  end
end
