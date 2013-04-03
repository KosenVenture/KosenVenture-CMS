json.array!(@users) do |user|
  json.extract! user, :name, :real_name, :password_digest
  json.url user_url(user, format: :json)
end