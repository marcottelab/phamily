require 'test_helper'

class PhenotypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phenotypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phenotype" do
    assert_difference('Phenotype.count') do
      post :create, :phenotype => { }
    end

    assert_redirected_to phenotype_path(assigns(:phenotype))
  end

  test "should show phenotype" do
    get :show, :id => phenotypes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => phenotypes(:one).to_param
    assert_response :success
  end

  test "should update phenotype" do
    put :update, :id => phenotypes(:one).to_param, :phenotype => { }
    assert_redirected_to phenotype_path(assigns(:phenotype))
  end

  test "should destroy phenotype" do
    assert_difference('Phenotype.count', -1) do
      delete :destroy, :id => phenotypes(:one).to_param
    end

    assert_redirected_to phenotypes_path
  end
end
