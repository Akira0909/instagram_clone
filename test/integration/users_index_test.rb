require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  
  def setup
    @user = users(:michael)
  end

  #test "index including pagination" do
    #log_in_as(@user)
    #assert is_logged_in?
    #get users_path
    #assert_template 'users/index'
    #assert_select 'div.pagination'
    #User.paginate(page: 1).each do |user|
      #assert_select 'a[href=?]', user_path(user), text: user.user_name
    #end
  #end
end
