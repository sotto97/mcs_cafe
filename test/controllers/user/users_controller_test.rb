require 'test_helper'

class User::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_users_index_url
    assert_response :success
  end

  test "should get edit" do
    get user_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_users_update_url
    assert_response :success
  end

  test "should get hide" do
    get user_users_hide_url
    assert_response :success
  end

  test "should get notice" do
    get user_users_notice_url
    assert_response :success
  end

  test "should get create" do
    get user_users_create_url
    assert_response :success
  end

end
