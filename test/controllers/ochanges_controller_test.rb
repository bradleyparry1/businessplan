require 'test_helper'

class OchangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ochange = ochanges(:one)
  end

  test "should get index" do
    get ochanges_url
    assert_response :success
  end

  test "should get new" do
    get new_ochange_url
    assert_response :success
  end

  test "should create ochange" do
    assert_difference('Ochange.count') do
      post ochanges_url, params: { ochange: { account_id: @ochange.account_id, apr: @ochange.apr, aug: @ochange.aug, bmo_approved: @ochange.bmo_approved, central_approved: @ochange.central_approved, central_declined: @ochange.central_declined, dec: @ochange.dec, description: @ochange.description, feb: @ochange.feb, jan: @ochange.jan, jul: @ochange.jul, jun: @ochange.jun, mar: @ochange.mar, may: @ochange.may, nov: @ochange.nov, oct: @ochange.oct, other_id: @ochange.other_id, po_number: @ochange.po_number, sep: @ochange.sep, supplier: @ochange.supplier, team_id: @ochange.team_id } }
    end

    assert_redirected_to ochange_url(Ochange.last)
  end

  test "should show ochange" do
    get ochange_url(@ochange)
    assert_response :success
  end

  test "should get edit" do
    get edit_ochange_url(@ochange)
    assert_response :success
  end

  test "should update ochange" do
    patch ochange_url(@ochange), params: { ochange: { account_id: @ochange.account_id, apr: @ochange.apr, aug: @ochange.aug, bmo_approved: @ochange.bmo_approved, central_approved: @ochange.central_approved, central_declined: @ochange.central_declined, dec: @ochange.dec, description: @ochange.description, feb: @ochange.feb, jan: @ochange.jan, jul: @ochange.jul, jun: @ochange.jun, mar: @ochange.mar, may: @ochange.may, nov: @ochange.nov, oct: @ochange.oct, other_id: @ochange.other_id, po_number: @ochange.po_number, sep: @ochange.sep, supplier: @ochange.supplier, team_id: @ochange.team_id } }
    assert_redirected_to ochange_url(@ochange)
  end

  test "should destroy ochange" do
    assert_difference('Ochange.count', -1) do
      delete ochange_url(@ochange)
    end

    assert_redirected_to ochanges_url
  end
end
