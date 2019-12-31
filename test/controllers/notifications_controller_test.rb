require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:michael)
  end
  
  test "should get index" do
    sign_in(@user)
    get notifications_path
    assert_response :success
  end
end