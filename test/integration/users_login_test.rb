require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest 
  include Warden::Test::Helpers
  
  def setup
    @user = users(:michael)
  end
  
  test "sign_in with invalid information" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { session: { email: "", password: "" } }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "sign_in with valid information" do
    get new_user_session_path
    post user_session_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    #assert_redirected_to root_url
    #follow_redirect!
    #assert_template '/'
    #assert_select "a[href=?]", new_user_session_path, count: 0
    #assert_select "a[href=?]", user_path(@user)
    #assert_select "a[href=?]", notifications_path
    #delete destroy_user_session_path
    #assert_not is_logged_in?
    #assert_redirected_to root_url
    #follow_redirect!
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", notifications_path, count: 0
  end
end