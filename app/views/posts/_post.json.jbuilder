json.extract! post, :id, :title, :body, :organization_id, :created_at, :updated_at
json.url post_url(post, format: :json)
