module Resolvers
  class OrganizationsResolver < BaseResolver
    type [Types::OrganizationType], null: false

    def resolve
      organizations = Organization.all
      if organizations.any?
        organizations.to_a
      else
        raise GraphQL::ExecutionError, "Couldn't fetch Organizations"
      end
    end
  end
end
