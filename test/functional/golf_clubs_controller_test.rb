require 'test_helper'

class GolfClubsControllerTest < ActionController::TestCase
  setup do
    @golf_club = golf_clubs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:golf_clubs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create golf_club" do
    assert_difference('GolfClub.count') do
      post :create, :golf_club => @golf_club.attributes
    end

    assert_redirected_to golf_club_path(assigns(:golf_club))
  end

  test "should show golf_club" do
    get :show, :id => @golf_club.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @golf_club.to_param
    assert_response :success
  end

  test "should update golf_club" do
    put :update, :id => @golf_club.to_param, :golf_club => @golf_club.attributes
    assert_redirected_to golf_club_path(assigns(:golf_club))
  end

  test "should destroy golf_club" do
    assert_difference('GolfClub.count', -1) do
      delete :destroy, :id => @golf_club.to_param
    end

    assert_redirected_to golf_clubs_path
  end
end
