require 'test_helper'

class ChoresControllerTest < ActionController::TestCase
  setup do
    @create_custom_chore = create_custom_chores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create create_custom_chore" do
    assert_difference('CreateCustomChore.count') do
      post :create, create_custom_chore: {  }
    end

    assert_redirected_to create_custom_chore_path(assigns(:create_custom_chore))
  end

  test "should show create_custom_chore" do
    get :show, id: @create_custom_chore
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @create_custom_chore
    assert_response :success
  end

  test "should update create_custom_chore" do
    put :update, id: @create_custom_chore, create_custom_chore: {  }
    assert_redirected_to create_custom_chore_path(assigns(:create_custom_chore))
  end

  test "should destroy create_custom_chore" do
    assert_difference('CreateCustomChore.count', -1) do
      delete :destroy, id: @create_custom_chore
    end

    assert_redirected_to create_custom_chores_path
  end
end
