module Mutations
  class InviteMember < BaseMutation
    
    argument :email, String, required: true
    argument :user_id, Integer, required: true
    argument :organization_id, Integer, required: true


    field :membership, Types::MembershipType, null: true
    field :errors, [String], null: false
    field :message, String, null: true

    def resolve(email:, user_id:, organization_id:)
      return {membership:nil , errors: ["organization not found"], message: nil} unless organization = Organization.find_by(id: organization_id) 
      membership = Membership.find_by(user_id: user_id, organization_id: )
      if membership&.is_admin?
          # puts "send invitation to #{@email}"
          InviteMailer.invite_member_email(email, organization).deliver_later
          {membership:membership , errors: [], message: "Invitation send to email"}
      else
        {membership: nil , errors: ["Only admin can invite user"] ,message: nil}
      end
    end

  end 
end
