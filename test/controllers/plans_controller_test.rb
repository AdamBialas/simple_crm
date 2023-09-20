require "test_helper"

class plansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plan = plans(:one)
  end

  test "should get index" do
    get plans_url
    assert_response :success
  end

  test "should get new" do
    get new_plan_url
    assert_response :success
  end

  test "should create plan" do
    assert_difference('plan.count') do
      post plans_url, params: { plan: { event_date,: @plan.event_date,, event_description: @plan.event_description, event_name,: @plan.event_name, } }
    end

    assert_redirected_to plan_url(plan.last)
  end

  test "should show plan" do
    get plan_url(@plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_plan_url(@plan)
    assert_response :success
  end

  test "should update plan" do
    patch plan_url(@plan), params: { plan: { event_date,: @plan.event_date,, event_description: @plan.event_description, event_name,: @plan.event_name, } }
    assert_redirected_to plan_url(@plan)
  end

  test "should destroy plan" do
    assert_difference('plan.count', -1) do
      delete plan_url(@plan)
    end

    assert_redirected_to plans_url
  end
end
