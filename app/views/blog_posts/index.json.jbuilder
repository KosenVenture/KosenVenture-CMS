json.(@posts) do |json, post|
  json.(post, :id, :title, :published_at)
  json.author post.author, :real_name
  json.category_name (post.category ? post.category.title : 'なし')
  json.published_at_str l(post.published_at.to_date)
end