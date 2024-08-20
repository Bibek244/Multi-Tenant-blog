# Preview all emails at http://localhost:3000/rails/mailers/invite_mailer
class InviteMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invite_mailer/invite_member_email
  def invite_member_email
    InviteMailer.invite_member_email
  end

end
