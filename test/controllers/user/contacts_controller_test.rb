require 'test_helper'

class User::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_contacts_new_url
    assert_response :success
  end

  test "should get confirm" do
    get user_contacts_confirm_url
    assert_response :success
  end

  test "should get edit" do
    get user_contacts_edit_url
    assert_response :success
  end

  test "should get thanks" do
    get user_contacts_thanks_url
    assert_response :success
  end

end
