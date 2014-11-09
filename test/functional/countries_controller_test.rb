require File.expand_path("../../test_helper", __FILE__)

class CountriesControllerTest < ActionController::TestCase
  should_not_respond_to_actions :new => :get, :destroy => :get
  include Devise::TestHelpers
  setup do
    @country = countries(:one)
    @controller = CountriesController.new
    @user = users(:smart)
    sign_in(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should create country" do
    assert_difference('Country.count') do
      post :create, :country => @country.attributes.merge({ :code => Time.now.to_s })
    end

    assert_redirected_to country_path(assigns(:country))
  end

  test "should not create duplicate currency" do
    assert_no_difference('Currency.count') do
      post :create, :country => @country.attributes
    end

    assert !assigns[:country].errors[:code].empty?
  end

  test "should show country" do
    get :show, :id => @country.to_param
    assert_response :success
  end

  test 'should return correct chart data' do
    get :chart_data
    assert_response :success
    assert_equal [[1415484000000,1]], assigns(:chart_data)
  end

  test 'should return correct visiting counts' do
    get :counts
    assert_response :success
    assert_equal({'visited' => 1, 'unvisited' => 2}, assigns(:counts))
  end

end
