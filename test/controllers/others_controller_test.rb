require 'test_helper'

class OthersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @other = others(:one)
  end

  test "should get index" do
    get others_url
    assert_response :success
  end

  test "should get new" do
    get new_other_url
    assert_response :success
  end

  test "should create other" do
    assert_difference('Other.count') do
      post others_url, params: { other: { account_id: @other.account_id, apr: @other.apr, aug: @other.aug, dec: @other.dec, description: @other.description, feb: @other.feb, jan: @other.jan, jul: @other.jul, jun: @other.jun, mar: @other.mar, may: @other.may, nov: @other.nov, oct: @other.oct, po_number: @other.po_number, sep: @other.sep, supplier: @other.supplier, team_id: @other.team_id } }
    end

    assert_redirected_to other_url(Other.last)
  end

  test "should show other" do
    get other_url(@other)
    assert_response :success
  end

  test "should get edit" do
    get edit_other_url(@other)
    assert_response :success
  end

  test "should update other" do
    patch other_url(@other), params: { other: { account_id: @other.account_id, apr: @other.apr, aug: @other.aug, dec: @other.dec, description: @other.description, feb: @other.feb, jan: @other.jan, jul: @other.jul, jun: @other.jun, mar: @other.mar, may: @other.may, nov: @other.nov, oct: @other.oct, po_number: @other.po_number, sep: @other.sep, supplier: @other.supplier, team_id: @other.team_id } }
    assert_redirected_to other_url(@other)
  end

  test "should destroy other" do
    assert_difference('Other.count', -1) do
      delete other_url(@other)
    end

    assert_redirected_to others_url
  end
end
