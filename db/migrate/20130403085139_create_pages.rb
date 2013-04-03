class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :description
      t.text :body
      t.integer :category_id
      t.integer :author_id
      t.boolean :published
      t.datetime :published_at

      t.timestamps
    end
  end
end
