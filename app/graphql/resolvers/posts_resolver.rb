module Resolvers
  class PostsResolver < BaseResolver
    type Types::PostType, null: false
    
    def resolve
     post = Post.all
        if post
          { post: post, errors: [], message: "Succesfully fetched post " }
        else
          raise GraphQL::ExecutionError, { post: nil, errors: ["Couldn't fetch post"], message: nil }
        end
    end
    
  end
end