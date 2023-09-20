require "application_system_test_case"

class plansTest < ApplicationSystemTestCase
  setup do
    @planer = plans(:one)
  end

  test "visiting the index" do
    visit plans_url
    assert_selector "h1", text: "plans"
  end

  test "creating a Planer" do
    visit plans_url
    click_on "New Planer"

    fill_in "Event date,", with: @planer.event_date,
    fill_in "Event description", with: @planer.event_description
    fill_in "Event name,", with: @planer.event_name,
    click_on "Create Planer"

    assert_text "Planer was successfully created"
    click_on "Back"
  end

  test "updating a Planer" do
    visit plans_url
    click_on "Edit", match: :first

    fill_in "Event date,", with: @planer.event_date,
    fill_in "Event description", with: @planer.event_description
    fill_in "Event name,", with: @planer.event_name,
    click_on "Update Planer"

    assert_text "Planer was successfully updated"
    click_on "Back"
  end

  test "destroying a Planer" do
    visit plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Planer was successfully destroyed"
  end
end
