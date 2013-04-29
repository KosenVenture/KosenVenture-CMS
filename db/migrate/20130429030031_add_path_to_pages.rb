class AddPathToPages < ActiveRecord::Migration
  def up
    add_column :pages, :path, :string

    Page.all.each do |p|
      p.path = p.trace_path
      p.save!
    end
  end

  def down
    remove_column :pages, :path
  end
end
