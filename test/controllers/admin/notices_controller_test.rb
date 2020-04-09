require 'test_helper'

class Admin::NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_notices_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_notices_show_url
    assert_response :success
  end

end
