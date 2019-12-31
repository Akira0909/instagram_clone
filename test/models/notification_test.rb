require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  
  def setup
    @notification = Notification.new(visitor_id: users(:michael).id,
                                     visited_id: users(:archer).id,
                                     action: "follow",
                                     )
  end

  test "should be valid" do
    assert @notification.valid?
  end
end