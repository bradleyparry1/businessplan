require 'test_helper'

class PchangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pchange = pchanges(:one)
  end

  test "should get index" do
    get pchanges_url
    assert_response :success
  end

  test "should get new" do
    get new_pchange_url
    assert_response :success
  end

  test "should create pchange" do
    assert_difference('Pchange.count') do
      post pchanges_url, params: { pchange: { bmo_approved: @pchange.bmo_approved, brexit: @pchange.brexit, central_approved: @pchange.central_approved, end: @pchange.end, fte: @pchange.fte, person_id: @pchange.person_id, start: @pchange.start, team_id: @pchange.team_id } }
    end

    assert_redirected_to pchange_url(Pchange.last)
  end

  test "should show pchange" do
    get pchange_url(@pchange)
    assert_response :success
  end

  test "should get edit" do
    get edit_pchange_url(@pchange)
    assert_response :success
  end

  test "should update pchange" do
    patch pchange_url(@pchange), params: { pchange: { bmo_approved: @pchange.bmo_approved, brexit: @pchange.brexit, central_approved: @pchange.central_approved, end: @pchange.end, fte: @pchange.fte, person_id: @pchange.person_id, start: @pchange.start, team_id: @pchange.team_id } }
    assert_redirected_to pchange_url(@pchange)
  end

  test "should destroy pchange" do
    assert_difference('Pchange.count', -1) do
      delete pchange_url(@pchange)
    end

    assert_redirected_to pchanges_url
  end
end
