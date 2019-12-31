require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Instagram Clone"
  end
  
  test "should get terms" do
    get terms_path
    assert_response :success
    assert_select "title", "利用規約 | Instagram Clone"
  end
end