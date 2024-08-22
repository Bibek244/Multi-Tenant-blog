module Mutations
  class RegisterUser < BaseMutation
    
    argument :email, String, required: true
    argument :password, String, required: true
    argument :organization_id, ID, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve(email:, password:, organization_id:)
      user = User.find_by(email: email)
      organization = Organization.find_by(id: organization_id)

      if user.present?
        if user.valid_password?(password)
          Membership.find_or_create_by(user: user, organization: organization)
          { user: user, errors: [], message: "Successfully added #{user.email} to #{organization.name}" }
        else
          { user: nil, errors: ["Incorrect password for the existing user"], message: nil }
        end
      else
        user = User.new(email: email, password: password)
        if organization.present?
          if user.save
            Membership.find_or_create_by(user: user, organization: organization)
            { user: user, errors: [], message: "You've been added to the organization." }
          else
            { user: nil, errors: user.errors.full_messages, message: nil }
          end
        else
          { user: nil, errors: ["Organization not found"], message: nil }
        end
      end
    end
  end
end
