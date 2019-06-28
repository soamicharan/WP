require 'test_helper'

class CandidateDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @candidate_detail = candidate_details(:one)
  end

  test "should get index" do
    get candidate_details_url
    assert_response :success
  end

  test "should get new" do
    get new_candidate_detail_url
    assert_response :success
  end

  test "should create candidate_detail" do
    assert_difference('CandidateDetail.count') do
      post candidate_details_url, params: { candidate_detail: { DOC: @candidate_detail.DOC, DOR: @candidate_detail.DOR, address: @candidate_detail.address, age: @candidate_detail.age, branch: @candidate_detail.branch, contact_no: @candidate_detail.contact_no, email: @candidate_detail.email, experience: @candidate_detail.experience, gender: @candidate_detail.gender, name: @candidate_detail.name, qualification: @candidate_detail.qualification, reg_no: @candidate_detail.reg_no, remarks_mobility: @candidate_detail.remarks_mobility, s_no: @candidate_detail.s_no, specialization: @candidate_detail.specialization, src_reg: @candidate_detail.src_reg, state: @candidate_detail.state, status: @candidate_detail.status, zone: @candidate_detail.zone } }
    end

    assert_redirected_to candidate_detail_url(CandidateDetail.last)
  end

  test "should show candidate_detail" do
    get candidate_detail_url(@candidate_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_candidate_detail_url(@candidate_detail)
    assert_response :success
  end

  test "should update candidate_detail" do
    patch candidate_detail_url(@candidate_detail), params: { candidate_detail: { DOC: @candidate_detail.DOC, DOR: @candidate_detail.DOR, address: @candidate_detail.address, age: @candidate_detail.age, branch: @candidate_detail.branch, contact_no: @candidate_detail.contact_no, email: @candidate_detail.email, experience: @candidate_detail.experience, gender: @candidate_detail.gender, name: @candidate_detail.name, qualification: @candidate_detail.qualification, reg_no: @candidate_detail.reg_no, remarks_mobility: @candidate_detail.remarks_mobility, s_no: @candidate_detail.s_no, specialization: @candidate_detail.specialization, src_reg: @candidate_detail.src_reg, state: @candidate_detail.state, status: @candidate_detail.status, zone: @candidate_detail.zone } }
    assert_redirected_to candidate_detail_url(@candidate_detail)
  end

  test "should destroy candidate_detail" do
    assert_difference('CandidateDetail.count', -1) do
      delete candidate_detail_url(@candidate_detail)
    end

    assert_redirected_to candidate_details_url
  end
end
