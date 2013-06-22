class AddDepthToPage < ActiveRecord::Migration
  def change
    add_column :pages, :depth, :integer
    Page.all.each do |p|
      p.depth = p.trace_depth
      p.save!
    end
  end
end
