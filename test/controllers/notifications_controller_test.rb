require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  log_in_as(@user)
  
  test "should get index" do
    get notifications_path
    assert_response :success
  end

end
