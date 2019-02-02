require 'test_helper'

class TimeOffsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_off = time_offs(:one)
  end

  test "should get index" do
    get time_offs_url
    assert_response :success
  end

  test "should get new" do
    get new_time_off_url
    assert_response :success
  end

  test "should create time_off" do
    assert_difference('TimeOff.count') do
      post time_offs_url, params: { time_off: { from_date: @time_off.from_date, note: @time_off.note, to_date: @time_off.to_date, user_id: @time_off.user_id } }
    end

    assert_redirected_to time_off_url(TimeOff.last)
  end

  test "should show time_off" do
    get time_off_url(@time_off)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_off_url(@time_off)
    assert_response :success
  end

  test "should update time_off" do
    patch time_off_url(@time_off), params: { time_off: { from_date: @time_off.from_date, note: @time_off.note, to_date: @time_off.to_date, user_id: @time_off.user_id } }
    assert_redirected_to time_off_url(@time_off)
  end

  test "should destroy time_off" do
    assert_difference('TimeOff.count', -1) do
      delete time_off_url(@time_off)
    end

    assert_redirected_to time_offs_url
  end
end
