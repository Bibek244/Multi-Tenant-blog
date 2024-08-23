module InvitationsSender
  extend ActiveSupport::Concern


  included do
    after_action :invite_user, only: [:create]
  end

  private
  
  
  def invite_user
    if @email
      puts "send invitation to #{@email}"
          InviteMailer.invite_member_email(@email, @current_organization).deliver_later
          return status = "mail delivered."
      else
        return status = "failed to deliver."
      end
  end
end