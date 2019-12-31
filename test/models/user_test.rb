require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User",
        						 user_name: "Example",
        						 sex: "男",
        						 website: "https://www.instagram.com",
        						 self_introduction: "よろしくお願いします。",
        						 phone: "090-1234-5678",
        						 admin: false,
        						 image_name: "example.jpg",
        						 email: "example@gmail.com",
        						 password: "12345678",
        						 password_confirmation: "12345678"
        	           )	
    @user2 = User.new(name: "Example User 2",
        						 user_name: "Example2",
        						 sex: "女",
        						 website: "https://www.instagram.com",
        						 self_introduction: "よろしくお願いします。",
        						 phone: "080-1234-5678",
        						 admin: false,
        						 image_name: "example2.jpg",
        						 email: "example2@gmail.com",
        						 password: "87654321",
        						 password_confirmation: "87654321"
        	           )
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "user_name should be present" do
    @user.user_name = "     "
    assert_not @user.valid?
  end
  
  test "user_name should not be too long" do
    @user.user_name = "a" * 51
    assert_not @user.valid?
  end
  
  test "user_name should be unique" do
    @user.save
    @user2.user_name = "Example"
    @user2.save
    assert_not @user2.valid?
  end
  
  test "self_introduction should not be too long" do
    @user.self_introduction = "a" * 501
    assert_not @user.valid?
  end
  
  test "phone should not be too long" do
    @user.phone = "a" * 14
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  test "associated comments should be destroyed" do
    @user.save
    @micropost = @user.microposts.create!(content: "テストの投稿")
    @user.comments.create!(content: "テストのコメント",micropost_id: @micropost.id)
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end
  
  test "associated likes" do
    @user.save
    @micropost = @user.microposts.create!(content: "テストの投稿")
    @like = @user.likes.create!(micropost_id: @micropost.id)
    assert @like.valid?
  end
  
  test "associated notifications should be destroyed" do
    @user.save
    @user2.save
    @user.active_notifications.create!(visited_id: @user2.id,
                                       action: "follow",
                                       checked: false
                                       )
    assert_difference 'Notification.count', -1 do
      @user.destroy
    end
  end
  
  test "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
end