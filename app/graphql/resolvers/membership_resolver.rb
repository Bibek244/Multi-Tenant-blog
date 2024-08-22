module Resolvers
  class MembershipResolver < BaseResolver
    type [Types::MembershipType], null: false 
    argument :user_id, ID, required: true
    
    def resolve(user_id:)
      memberships = Membership.where(user_id: user_id)
      if memberships.any?
        memberships.to_a 
      else
        raise GraphQL::ExecutionError, { memberships: nil, errors: ["Couldn't fetch memberships"], message: nil }
      end
    end
  end
end
