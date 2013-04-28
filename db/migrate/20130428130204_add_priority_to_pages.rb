class AddPriorityToPages < ActiveRecord::Migration
  def change
    add_column :pages, :priority, :float
  end
end
