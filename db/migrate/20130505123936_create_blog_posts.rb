class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :intro
      t.text :body
      t.integer :author_id
      t.integer :category_id
      t.boolean :published
      t.datetime :published_at

      t.timestamps
    end
  end
end
