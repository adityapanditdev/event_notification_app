require "test_helper"

class EventNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_event" do
    get event_notifications_create_event_url
    assert_response :success
  end

  test "should get create_event_with_notification" do
    get event_notifications_create_event_with_notification_url
    assert_response :success
  end
end
