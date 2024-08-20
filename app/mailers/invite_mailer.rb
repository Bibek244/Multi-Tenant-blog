class InviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.invite_member_email.subject
  #
  def invite_member_email(email, organization)
    @email = email
    @organization = organization

    mail(
      to: @email,
      subject: "Invitations to join #{@organization.name}",
      from: "invite@fleetpanda.com"
    )
  end
end
