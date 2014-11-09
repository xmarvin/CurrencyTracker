require File.expand_path("../../test_helper", __FILE__)

class CurrenciesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  should_not_respond_to_actions :new => :get,
                                :destroy => :get,
                                :create => :post,
                                :edit => :get,
                                :update => :put

  setup do
    @controller = CurrenciesController.new
    @currency = currencies(:one)
    @user = users(:smart)
    sign_in(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "should show currency" do
    get :show, :id => @currency.to_param
    assert_response :success
  end

  test 'should return correct chart data' do
    get :chart_data
    assert_response :success
    assert_equal [[1415484000000,2]], assigns(:chart_data)
  end

  test 'should return correct visiting counts' do
    get :counts
    assert_response :success
    assert_equal({'collected' => 2, 'uncollected' => 1}, assigns(:counts))
  end

end
