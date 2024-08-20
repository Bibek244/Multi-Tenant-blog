class UserMailer < ApplicationMailer
  def organization_invitation(user, organization)
    @user = user
    @organization = organization
    mail(to: @user.email, subject: "You're invited to join #{@organization.name}")
  end
end