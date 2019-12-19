require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  
  def setup
    @like = Like.new(user_id: users(:michael).id,
                     micropost_id: microposts(:orange).id
                     )
  end
  
  test "should be valid" do
    assert @like.valid?
  end
  
  test "should require a user_id" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "should require a micropost_id" do
    @like.micropost_id = nil
    assert_not @like.valid?
  end
  
  test "should like and unlike a micropost" do
    michael = users(:michael)
    micropost = microposts(:orange)
    assert_not michael.likepost?(micropost)
    michael.like(micropost)
    assert michael.likepost?(micropost)
    assert micropost.liked_users.include?(michael)
  end
  
end
