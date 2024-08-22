module Resolvers
  class ProfileResolver < BaseResolver
    type Types::ProfileType, null: true
    argument :id, ID, required: true

    def resolve(id:)
      profile = Profile.find_by(user_id: id)
      if profile
        profile
      else
        raise GraphQL::ExecutionError, "Profile doesnot exist"
      end
    end

  end
end
