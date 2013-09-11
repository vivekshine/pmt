require 'test_helper'

class FeedbackMailerTest < ActionMailer::TestCase
  test "confirm" do
    @expected.subject = 'FeedbackMailer#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, FeedbackMailer.create_confirm(@expected.date).encoded
  end

  test "sent" do
    @expected.subject = 'FeedbackMailer#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, FeedbackMailer.create_sent(@expected.date).encoded
  end

end
