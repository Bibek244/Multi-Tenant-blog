module Mutations
  class UpdatePost < BaseMutation
    argument :title, String, required: true
    argument :body, String, required: true
    argument :user_id, Integer, required: true
    argument :organization_id, Integer, required: true
    argument :post_id, Integer, required: true
    

    field :post, Types::PostType, null: true
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve(title:, body:, user_id:, organization_id:, post_id:)
      post = Post.find_by(id: post_id)
      if post.user_id == user_id
        membership = Membership.find_by(user_id: user_id, organization_id: organization_id)
        if membership
          post.update(title:, body:, user_id:, organization_id:)
          if post.save
            { post: post, errors: [], message: "Successfully create a post by #{user_id} for #{organization_id}" }
          else
            { post: nil, errors: ["Failed to created a post."], message: nil }
          end
        else
            { post: nil, errors: ["Can't update a post where user is not member of the organization"], message: nil }
        end
      else
        { post: nil, errors: ["Cannot edit this post!"], message: nil }
      end
    end

  end
end
