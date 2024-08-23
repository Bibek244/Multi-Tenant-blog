# frozen_string_literal: true

module Types
  class ProfileType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String
    field :last_name, String
    field :email, String
    field :address, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_id, Integer, null: false
    field :avatar_url, String, null: true
  end

  def avatar_url
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true) if object.avatar.attached?
  end
end
