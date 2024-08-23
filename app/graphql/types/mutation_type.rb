# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    field :login_user, mutation: Mutations::LoginUser
    field :create_post, mutation: Mutations::CreatePost
    field :update_post, mutation: Mutations::UpdatePost
    field :invite_memeber, mutation: Mutations::InviteMember
    field :delete_post, mutation: Mutations::DeletePost
    field :create_profile, mutation: Mutations::CreateProfile
    field :create_comment, mutation: Mutations::CreateComment
  end
end
