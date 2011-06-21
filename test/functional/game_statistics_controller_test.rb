require 'test_helper'

class GameStatisticsControllerTest < ActionController::TestCase
  setup do
    @game_statistic = game_statistics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_statistics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_statistic" do
    assert_difference('GameStatistic.count') do
      post :create, :game_statistic => @game_statistic.attributes
    end

    assert_redirected_to game_statistic_path(assigns(:game_statistic))
  end

  test "should show game_statistic" do
    get :show, :id => @game_statistic.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @game_statistic.to_param
    assert_response :success
  end

  test "should update game_statistic" do
    put :update, :id => @game_statistic.to_param, :game_statistic => @game_statistic.attributes
    assert_redirected_to game_statistic_path(assigns(:game_statistic))
  end

  test "should destroy game_statistic" do
    assert_difference('GameStatistic.count', -1) do
      delete :destroy, :id => @game_statistic.to_param
    end

    assert_redirected_to game_statistics_path
  end
end
