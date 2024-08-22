module Resolvers
  class PostResolver < BaseResolver
    type Types::PostType, null: false
    argument :id, ID, required: true
    
    def resolve(id:)
     post = Post.find(id)
        if post
          { post: post, errors: [], message: "Succesfully fetched post " }
        else
        raise GraphQL::ExecutionError, { post: nil, errors: ["Couldn't fetch post"], message: nil }
        end
    end
    
  end
end