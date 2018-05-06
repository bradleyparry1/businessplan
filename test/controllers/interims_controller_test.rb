require 'test_helper'

class InterimsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interim = interims(:one)
  end

  test "should get index" do
    get interims_url
    assert_response :success
  end

  test "should get new" do
    get new_interim_url
    assert_response :success
  end

  test "should create interim" do
    assert_difference('Interim.count') do
      post interims_url, params: { interim: { charge_rate: @interim.charge_rate, community_id: @interim.community_id, framework_id: @interim.framework_id, grade_id: @interim.grade_id, job_title: @interim.job_title, name: @interim.name, profession_id: @interim.profession_id, role_id: @interim.role_id, staff_number: @interim.staff_number, status_id: @interim.status_id } }
    end

    assert_redirected_to interim_url(Interim.last)
  end

  test "should show interim" do
    get interim_url(@interim)
    assert_response :success
  end

  test "should get edit" do
    get edit_interim_url(@interim)
    assert_response :success
  end

  test "should update interim" do
    patch interim_url(@interim), params: { interim: { charge_rate: @interim.charge_rate, community_id: @interim.community_id, framework_id: @interim.framework_id, grade_id: @interim.grade_id, job_title: @interim.job_title, name: @interim.name, profession_id: @interim.profession_id, role_id: @interim.role_id, staff_number: @interim.staff_number, status_id: @interim.status_id } }
    assert_redirected_to interim_url(@interim)
  end

  test "should destroy interim" do
    assert_difference('Interim.count', -1) do
      delete interim_url(@interim)
    end

    assert_redirected_to interims_url
  end
end
