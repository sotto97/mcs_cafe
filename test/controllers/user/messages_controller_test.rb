require 'test_helper'

class User::MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_messages_show_url
    assert_response :success
  end

  test "should get create" do
    get user_messages_create_url
    assert_response :success
  end

end
