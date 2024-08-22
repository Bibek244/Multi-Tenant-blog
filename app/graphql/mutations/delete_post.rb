module Mutations
  class DeletePost < BaseMutation
    argument :post_id, Integer, required: true
    argument :user_id, Integer, required: true
    argument :organization_id, Integer, required: true
    

    field :post, Types::PostType, null: true
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve(post_id:, user_id:, organization_id:)
      post = Post.find_by(id: post_id)
      if post.user_id == user_id
        membership = Membership.find_by(user_id: user_id, organization_id: organization_id)
        if membership
          if post.destroy!
            { post: post, errors: [], message: "Successfully deleted the post" }
          else
            { post: nil, errors: ["Failed to destroy the post."], message: nil }
          end
        else
            { post: nil, errors: ["Can't delete a post where user is not member of the organization"], message: nil }
        end
      else
        { post: nil, errors: ["Only author can delete their post."], message: nil }
      end
      
    end

  end
end
