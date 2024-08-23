module Mutations
  class CreateComment < BaseMutation
    argument :user_id, ID, required: true
    argument :post_id, ID, required: true
    argument :body, String, required: true
    

    field :comment, Types::CommentType, null: true
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve( body:, user_id:, post_id:)
      post = Post.find_by(id: post_id)
      unless post.nil?
        comment = Comment.create(body:, user_id:, post_id:)
        if comment.save
          { comment: comment, errors: [], message: "Successfully create a comment" }
        else
          { comment: nil, errors: ["Failed to created a comment."], message: nil }
        end     
      else
        { comment: nil, errors: ["This post doesn't exist."], message: nil }
      end
    end

  end
end
