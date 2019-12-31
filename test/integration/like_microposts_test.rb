require 'test_helper'

class LikeMicropostsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:michael)
    @other = users(:archer)
    @micropost = microposts(:orange)
    sign_in(@user)
  end
  
  test "like microposts page" do
    get likes_user_path(@user)
    assert_not @user.likepost?(@micropost)
    assert_match @user.likeposts.count.to_s, response.body
    @user.likeposts.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
  
  test "should like a micropost" do
    assert_difference '@user.likeposts.count', 1 do
      post likes_path, params: { micropost_id: @micropost.id }
    end
  end

  test "should unlike a micropost" do
    @user.like(@micropost)
    assert_difference '@user.likeposts.count', -1 do
      @user.unlike(@micropost)
    end
  end
end