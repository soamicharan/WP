# == Schema Information
#
# Table name: candidate_details
#
#  id               :bigint           not null, primary key
#  DOC              :date
#  DOR              :date
#  address          :text
#  age              :integer
#  branch           :string
#  contact_no       :string
#  email            :string
#  experience       :string
#  gender           :string
#  name             :string
#  qualification    :string
#  reg_no           :string
#  remarks_mobility :integer
#  s_no             :integer
#  specialization   :string
#  src_reg          :string
#  state            :string
#  status           :string
#  zone             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_candidate_details_on_contact_no  (contact_no) UNIQUE
#  index_candidate_details_on_email       (email) UNIQUE
#  index_candidate_details_on_s_no        (s_no) UNIQUE
#

require 'test_helper'

class CandidateDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
