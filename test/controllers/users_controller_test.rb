require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  
  test "should get new" do
    get new_user_registration_url
    assert_response :success
  end
  
  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to new_user_session_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to new_user_session_url
  end

end
