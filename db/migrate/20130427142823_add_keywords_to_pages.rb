class AddKeywordsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :keywords, :text
  end
end
