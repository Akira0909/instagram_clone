require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:michael)
  end

  test "index including pagination" do
    sign_in(@user)
    get users_path
    assert_template 'users/index'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.user_name
    end
  end
end