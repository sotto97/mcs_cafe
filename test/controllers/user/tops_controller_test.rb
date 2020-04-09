require 'test_helper'

class User::TopsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get user_tops_top_url
    assert_response :success
  end

end
