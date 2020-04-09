require 'test_helper'

class Admin::MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_menus_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_menus_update_url
    assert_response :success
  end

end
