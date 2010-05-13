require 'test_helper'

class OrthogroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orthogroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orthogroup" do
    assert_difference('Orthogroup.count') do
      post :create, :orthogroup => { }
    end

    assert_redirected_to orthogroup_path(assigns(:orthogroup))
  end

  test "should show orthogroup" do
    get :show, :id => orthogroups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orthogroups(:one).to_param
    assert_response :success
  end

  test "should update orthogroup" do
    put :update, :id => orthogroups(:one).to_param, :orthogroup => { }
    assert_redirected_to orthogroup_path(assigns(:orthogroup))
  end

  test "should destroy orthogroup" do
    assert_difference('Orthogroup.count', -1) do
      delete :destroy, :id => orthogroups(:one).to_param
    end

    assert_redirected_to orthogroups_path
  end
end
