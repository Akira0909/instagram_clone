require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = Comment.new(user_id: users(:michael).id,
                     micropost_id: microposts(:orange).id,
                     content: "実験のコメントです"
                     )
  end
  
  test "should be valid" do
    assert @comment.valid?
  end
  
  test "should require a user_id" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "should require a micropost_id" do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end
  
  test "should require a content" do
    @comment.content = nil
    assert_not @comment.valid?
  end
  
  test "content should be at most 140 characters" do
    @comment.content = "a" * 141
    assert_not @comment.valid?
  end
end