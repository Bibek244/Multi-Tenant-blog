

module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false  
    field :title, String
    field :body, String
    field :organization_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_id, Integer, null: false
  end
end
