require 'test_helper'

class ActualsControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get actuals_view_url
    assert_response :success
  end

end
