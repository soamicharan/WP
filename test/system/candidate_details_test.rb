require "application_system_test_case"

class CandidateDetailsTest < ApplicationSystemTestCase
  setup do
    @candidate_detail = candidate_details(:one)
  end

  test "visiting the index" do
    visit candidate_details_url
    assert_selector "h1", text: "Candidate Details"
  end

  test "creating a Candidate detail" do
    visit candidate_details_url
    click_on "New Candidate Detail"

    fill_in "Doc", with: @candidate_detail.DOC
    fill_in "Dor", with: @candidate_detail.DOR
    fill_in "Address", with: @candidate_detail.address
    fill_in "Age", with: @candidate_detail.age
    fill_in "Branch", with: @candidate_detail.branch
    fill_in "Contact no", with: @candidate_detail.contact_no
    fill_in "Email", with: @candidate_detail.email
    fill_in "Experience", with: @candidate_detail.experience
    fill_in "Gender", with: @candidate_detail.gender
    fill_in "Name", with: @candidate_detail.name
    fill_in "Qualification", with: @candidate_detail.qualification
    fill_in "Reg no", with: @candidate_detail.reg_no
    fill_in "Remarks mobility", with: @candidate_detail.remarks_mobility
    fill_in "S no", with: @candidate_detail.s_no
    fill_in "Specialization", with: @candidate_detail.specialization
    fill_in "Src reg", with: @candidate_detail.src_reg
    fill_in "State", with: @candidate_detail.state
    fill_in "Status", with: @candidate_detail.status
    fill_in "Zone", with: @candidate_detail.zone
    click_on "Create Candidate detail"

    assert_text "Candidate detail was successfully created"
    click_on "Back"
  end

  test "updating a Candidate detail" do
    visit candidate_details_url
    click_on "Edit", match: :first

    fill_in "Doc", with: @candidate_detail.DOC
    fill_in "Dor", with: @candidate_detail.DOR
    fill_in "Address", with: @candidate_detail.address
    fill_in "Age", with: @candidate_detail.age
    fill_in "Branch", with: @candidate_detail.branch
    fill_in "Contact no", with: @candidate_detail.contact_no
    fill_in "Email", with: @candidate_detail.email
    fill_in "Experience", with: @candidate_detail.experience
    fill_in "Gender", with: @candidate_detail.gender
    fill_in "Name", with: @candidate_detail.name
    fill_in "Qualification", with: @candidate_detail.qualification
    fill_in "Reg no", with: @candidate_detail.reg_no
    fill_in "Remarks mobility", with: @candidate_detail.remarks_mobility
    fill_in "S no", with: @candidate_detail.s_no
    fill_in "Specialization", with: @candidate_detail.specialization
    fill_in "Src reg", with: @candidate_detail.src_reg
    fill_in "State", with: @candidate_detail.state
    fill_in "Status", with: @candidate_detail.status
    fill_in "Zone", with: @candidate_detail.zone
    click_on "Update Candidate detail"

    assert_text "Candidate detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Candidate detail" do
    visit candidate_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Candidate detail was successfully destroyed"
  end
end
