require 'test_helper'

class AdminControlControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_panel" do
    get admin_control_admin_panel_url
    assert_response :success
  end

  test "should get admin_panel_create" do
    get admin_control_admin_panel_create_url
    assert_response :success
  end

  test "should get admin_panel_delete" do
    get admin_control_admin_panel_delete_url
    assert_response :success
  end

  test "should get admin_panel_update" do
    get admin_control_admin_panel_update_url
    assert_response :success
  end

  test "should get create_user" do
    get admin_control_create_user_url
    assert_response :success
  end

  test "should get delete_user" do
    get admin_control_delete_user_url
    assert_response :success
  end

  test "should get edit_user" do
    get admin_control_edit_user_url
    assert_response :success
  end

end
