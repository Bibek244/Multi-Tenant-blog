# frozen_string_literal: true

module Types
  # require_relative 'resolvers/organizations_resolver'
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    
    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

   
    field :post, resolver: Resolvers::PostResolver
    field :posts, resolver: Resolvers::PostsResolver
    field :profile, resolver: Resolvers::ProfileResolver
    field :organization, resolver: Resolvers::OrganizationResolver
    field :organizations, resolver: Resolvers::OrganizationsResolver
    field :membership, resolver: Resolvers::MembershipResolver
    field :comments, resolver: Resolvers::CommentResolver

    # field :posts, [Types::PostType], null: false, description: "Fetch all posts"
    # def posts
    #   Post.all
    # end
  end
end
