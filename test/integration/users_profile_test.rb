require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.user_name)
    assert_select 'h1', text: @user.user_name
    assert_select 'h1>img'
    assert_match @user.microposts.count.to_s, response.body
  end
  
end
