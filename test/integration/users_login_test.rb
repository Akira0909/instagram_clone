require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest  
  include Warden::Test::Helpers
  
  def setup
    Warden.test_mode!
    @user = users(:michael)
  end
  
  test "login with invalid information" do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { session: { email: "", password: "" } }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  #test "login with valid information" do
    #get new_user_session_path
    #post user_session_path, params: { session: { email: @user.email,
                                          #password: 'password' } }
    #assert is_logged_in?
    #assert_redirected_to @user
    #follow_redirect!
    #assert_template '/'
    #assert_select "a[href=?]", new_user_session_path, count: 0
    #assert_select "a[href=?]", destroy_user_session_path
    #assert_select "a[href=?]", user_path(@user)
    #delete destroy_user_session_path
    #assert_not is_logged_in?
    #assert_redirected_to root_url
    #follow_redirect!
    #assert_select "a[href=?]", login_path
    #assert_select "a[href=?]", logout_path,      count: 0
    #assert_select "a[href=?]", user_path(@user), count: 0
  #end
  
end