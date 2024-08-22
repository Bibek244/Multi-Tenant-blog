module Resolvers
  class OrganizationResolver < BaseResolver
    type Types::OrganizationType, null: false
    argument :id, ID, required: true
    
    def resolve(id:)
     organization = Organization.find(id)
        if organization
          { organization: organization, errors: [], message: "Succesfully fetched organization " }
        else
        raise GraphQL::ExecutionError, { organization: nil, errors: ["Couldn't fetch organization"], message: nil }
        end
    end

  end
end
