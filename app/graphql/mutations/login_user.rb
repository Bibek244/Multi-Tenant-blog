module Mutations
  class LoginUser < BaseMutation
    
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false
    field :message, String, null: true  

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user&.valid_password?(password)  
        { user: user, errors: [], message: "Successfully login for #{user.email}" }
      else
        { user: nil, errors: ["Incorrect email or password"], message: nil }
      end
    end

  end
end