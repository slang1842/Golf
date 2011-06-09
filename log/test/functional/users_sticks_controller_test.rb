require 'test_helper'

class UsersSticksControllerTest < ActionController::TestCase
  setup do
    @users_stick = users_sticks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_sticks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_stick" do
    assert_difference('UsersStick.count') do
      post :create, :users_stick => @users_stick.attributes
    end

    assert_redirected_to users_stick_path(assigns(:users_stick))
  end

  test "should show users_stick" do
    get :show, :id => @users_stick.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @users_stick.to_param
    assert_response :success
  end

  test "should update users_stick" do
    put :update, :id => @users_stick.to_param, :users_stick => @users_stick.attributes
    assert_redirected_to users_stick_path(assigns(:users_stick))
  end

  test "should destroy users_stick" do
    assert_difference('UsersStick.count', -1) do
      delete :destroy, :id => @users_stick.to_param
    end

    assert_redirected_to users_sticks_path
  end
end
