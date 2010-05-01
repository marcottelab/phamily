require 'test_helper'

class PhenologsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phenologs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phenolog" do
    assert_difference('Phenolog.count') do
      post :create, :phenolog => { }
    end

    assert_redirected_to phenolog_path(assigns(:phenolog))
  end

  test "should show phenolog" do
    get :show, :id => phenologs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => phenologs(:one).to_param
    assert_response :success
  end

  test "should update phenolog" do
    put :update, :id => phenologs(:one).to_param, :phenolog => { }
    assert_redirected_to phenolog_path(assigns(:phenolog))
  end

  test "should destroy phenolog" do
    assert_difference('Phenolog.count', -1) do
      delete :destroy, :id => phenologs(:one).to_param
    end

    assert_redirected_to phenologs_path
  end
end
