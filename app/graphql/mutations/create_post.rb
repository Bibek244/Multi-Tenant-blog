module Mutations
  class CreatePost < BaseMutation
    argument :title, String, required: true
    argument :body, String, required: true
    argument :user_id, String, required: true
    argument :organization_id, String, required: true
    

    field :post, Types::PostType, null: true
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve(title:, body:, user_id:, organization_id:)
      membership = Membership.find_by(user_id: user_id, organization_id: organization_id)
      if membership
        post = Post.create(title:, body:, user_id:, organization_id:)
        if post.save
          { post: post, errors: [], message: "Successfully create a post by #{user_id} for #{organization_id}" }
        else
          { post: nil, errors: ["Failed to created a post."], message: nil }
        end
      else
          { post: nil, errors: ["Can't create a post where user is not member of the organization"], message: nil }
      end
      
    end

  end
end
