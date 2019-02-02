require "application_system_test_case"

class TimeOffsTest < ApplicationSystemTestCase
  setup do
    @time_off = time_offs(:one)
  end

  test "visiting the index" do
    visit time_offs_url
    assert_selector "h1", text: "Time Offs"
  end

  test "creating a Time off" do
    visit time_offs_url
    click_on "New Time Off"

    fill_in "From date", with: @time_off.from_date
    fill_in "Note", with: @time_off.note
    fill_in "To date", with: @time_off.to_date
    fill_in "User", with: @time_off.user_id
    click_on "Create Time off"

    assert_text "Time off was successfully created"
    click_on "Back"
  end

  test "updating a Time off" do
    visit time_offs_url
    click_on "Edit", match: :first

    fill_in "From date", with: @time_off.from_date
    fill_in "Note", with: @time_off.note
    fill_in "To date", with: @time_off.to_date
    fill_in "User", with: @time_off.user_id
    click_on "Update Time off"

    assert_text "Time off was successfully updated"
    click_on "Back"
  end

  test "destroying a Time off" do
    visit time_offs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Time off was successfully destroyed"
  end
end
