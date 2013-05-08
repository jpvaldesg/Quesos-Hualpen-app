require 'test_helper'

class MailerControllerTest < ActionController::TestCase
  test "should get readInbox" do
    get :readInbox
    assert_response :success
  end

end
