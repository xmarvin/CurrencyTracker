require File.expand_path("../../test_helper", __FILE__)

class VisitsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @controller = VisitsController.new
    @currency = currencies(:one)
    @user = users(:smart)
    sign_in(@user)
  end

  test "should remove visit if checked is false" do
    post :bulk_update,  bulk: [{code: 'One', checked: false}]
    assert_response :success
    assert_blank @user.visits
  end

  test "should add visit if checked is true" do
    post :bulk_update,  bulk: [{code: 'Two', checked: true}]
    assert_response :success
    assert_equal ['One', 'Two'], @user.visits.map(&:country_id)
  end

end
