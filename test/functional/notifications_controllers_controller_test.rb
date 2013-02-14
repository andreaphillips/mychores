require 'test_helper'

class NotificationsControllersControllerTest < ActionController::TestCase
  setup do
    @notifications_controller = notifications_controllers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notifications_controllers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notifications_controller" do
    assert_difference('NotificationsController.count') do
      post :create, notifications_controller: {  }
    end

    assert_redirected_to notifications_controller_path(assigns(:notifications_controller))
  end

  test "should show notifications_controller" do
    get :show, id: @notifications_controller
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notifications_controller
    assert_response :success
  end

  test "should update notifications_controller" do
    put :update, id: @notifications_controller, notifications_controller: {  }
    assert_redirected_to notifications_controller_path(assigns(:notifications_controller))
  end

  test "should destroy notifications_controller" do
    assert_difference('NotificationsController.count', -1) do
      delete :destroy, id: @notifications_controller
    end

    assert_redirected_to notifications_controllers_path
  end
end
