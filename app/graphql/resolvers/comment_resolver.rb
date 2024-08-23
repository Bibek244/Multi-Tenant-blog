module Resolvers
  class CommentResolver < BaseResolver
    type [Types::CommentType], null: false

    argument :post_id, ID, required: true
    
    def resolve(post_id:)
      post = Post.find_by(post_id)
      unless post.nil?
       comments = Comment.where(post_id: post_id)
        if comments
          comments
        else
          raise GraphQL::ExecutionError, { comment: nil, errors: ["Couldn't fetch comment"], message: nil }
        end
      else
        raise GraphQL::ExecutionError, { comment: nil, errors: ["This post doesnot exist"], message: nil }
      end
    end
  end
end