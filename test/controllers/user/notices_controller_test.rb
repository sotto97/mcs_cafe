require 'test_helper'

class User::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_notices_new_url
    assert_response :success
  end

  test "should get create" do
    get user_notices_create_url
    assert_response :success
  end

end
