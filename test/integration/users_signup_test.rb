require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

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
    # assert_template 'users/sign_up'
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
    assert_template '/'
    assert_not flash.blank?
  end
  
end