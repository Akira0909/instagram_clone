require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: 
                                              { name:  "",
                                                user_name: "",
                                                email: "user@invalid",
                                                password:              "foo",
                                                password_confirmation: "bar" 
                                                }
                                              }
    end
    assert_template 'registrations/new'
    assert_select   'div#error_explanation'
    assert_select   'div.field_with_errors'
  end
  
  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: 
                                              { name:  "Example User",
                                                user_name: "User",
                                                email: "user@example.com",
                                                password:              "password",
                                                password_confirmation: "password" 
                                                }
                                              }
    end
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.blank?
    assert_select "a[href=?]", new_user_session_path, count: 0
    assert_select "a[href=?]", notifications_path
    # assert is_logged_in?
  end
end