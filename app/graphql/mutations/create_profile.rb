module Mutations
  class CreateProfile < BaseMutation
    argument :user_id, ID, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :address, String, required: true
    argument :avatar, ApolloUploadServer::Upload, required: false

    type Types::ProfileType, null: true
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve(user_id:, first_name:, last_name:, email:, address: nil, avatar: nil )
      user= User.find_by(id: user_id)
      unless user.nil?
        profile = Profile.find_by_user_id(user_id)
      
        if profile.nil?
          profile =  Profile.create(first_name: first_name, last_name: last_name, email: email, address: address, user_id: user_id)
          if profile.save
            { profile: profile, errors: [], message: "Successfully create a profile for #{user_id}"}
          else
            { profile: nil, errors: ["Failed to created a profile."], message: nil }
          end
        else
            { profile: nil, errors: ["Can't create profile for the user who has already created profile"], message: nil }
        end
      else
        {profile: nil, errors: ["User doesnot exist."], message: nil}
      end
      
    end

  end
end
