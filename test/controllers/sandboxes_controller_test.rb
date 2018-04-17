require 'test_helper'

class SandboxesControllerTest < ActionDispatch::IntegrationTest
  test "should get people" do
    get sandboxes_people_url
    assert_response :success
  end

  test "should get other" do
    get sandboxes_other_url
    assert_response :success
  end

end
