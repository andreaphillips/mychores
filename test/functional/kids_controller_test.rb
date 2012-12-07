require 'test_helper'

class KidsControllerTest < ActionController::TestCase
  setup do
    @kid = kids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kid" do
    assert_difference('Kid.count') do
      post :create, kid: { age: @kid.age, chore_amount: @kid.chore_amount, name: @kid.name, parent_id: @kid.parent_id, picture: @kid.picture, reward_percent: @kid.reward_percent, sex: @kid.sex }
    end

    assert_redirected_to kid_path(assigns(:kid))
  end

  test "should show kid" do
    get :show, id: @kid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kid
    assert_response :success
  end

  test "should update kid" do
    put :update, id: @kid, kid: { age: @kid.age, chore_amount: @kid.chore_amount, name: @kid.name, parent_id: @kid.parent_id, picture: @kid.picture, reward_percent: @kid.reward_percent, sex: @kid.sex }
    assert_redirected_to kid_path(assigns(:kid))
  end

  test "should destroy kid" do
    assert_difference('Kid.count', -1) do
      delete :destroy, id: @kid
    end

    assert_redirected_to kids_path
  end
end
