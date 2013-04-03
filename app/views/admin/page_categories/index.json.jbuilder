json.array!(@page_categories) do |page_category|
  json.extract! page_category, :name, :title
  json.url page_category_url(page_category, format: :json)
end