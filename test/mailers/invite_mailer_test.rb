require "test_helper"

class InviteMailerTest < ActionMailer::TestCase
  test "invite_member_email" do
    mail = InviteMailer.invite_member_email
    assert_equal "Invite member email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
