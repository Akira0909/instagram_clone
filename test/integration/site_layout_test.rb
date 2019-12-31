require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:michael)
  end
  
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", new_user_session_path
    get new_user_session_path
    assert_select "title", full_title("ログイン")
  end
  
  test "layout links sign_in" do
    sign_in @user
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", notifications_path
    assert_select "a[href=?]", user_path(@user)
    get notifications_path
    assert_select "title", full_title("通知一覧")
  end
end