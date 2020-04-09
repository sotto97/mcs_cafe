require 'test_helper'

class Admin::NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_news_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_news_show_url
    assert_response :success
  end

  test "should get create" do
    get admin_news_create_url
    assert_response :success
  end

end
