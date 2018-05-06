require 'test_helper'

class CivilServantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @civil_servant = civil_servants(:one)
  end

  test "should get index" do
    get civil_servants_url
    assert_response :success
  end

  test "should get new" do
    get new_civil_servant_url
    assert_response :success
  end

  test "should create civil_servant" do
    assert_difference('CivilServant.count') do
      post civil_servants_url, params: { civil_servant: { community_id: @civil_servant.community_id, framework_id: @civil_servant.framework_id, grade_id: @civil_servant.grade_id, job_title: @civil_servant.job_title, name: @civil_servant.name, profession_id: @civil_servant.profession_id, role_id: @civil_servant.role_id, staff_number: @civil_servant.staff_number, status_id: @civil_servant.status_id } }
    end

    assert_redirected_to civil_servant_url(CivilServant.last)
  end

  test "should show civil_servant" do
    get civil_servant_url(@civil_servant)
    assert_response :success
  end

  test "should get edit" do
    get edit_civil_servant_url(@civil_servant)
    assert_response :success
  end

  test "should update civil_servant" do
    patch civil_servant_url(@civil_servant), params: { civil_servant: { community_id: @civil_servant.community_id, framework_id: @civil_servant.framework_id, grade_id: @civil_servant.grade_id, job_title: @civil_servant.job_title, name: @civil_servant.name, profession_id: @civil_servant.profession_id, role_id: @civil_servant.role_id, staff_number: @civil_servant.staff_number, status_id: @civil_servant.status_id } }
    assert_redirected_to civil_servant_url(@civil_servant)
  end

  test "should destroy civil_servant" do
    assert_difference('CivilServant.count', -1) do
      delete civil_servant_url(@civil_servant)
    end

    assert_redirected_to civil_servants_url
  end
end
