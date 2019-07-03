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

class CandidateDetail < ApplicationRecord
  validates :src_reg, presence:{message:"Source of registration must specified"}
  validates :name, presence:{message:"must specified."}
  validates :gender, presence:{message:"must specified."}
  validates :age, presence: {message:"must specified."}
  validates :age, inclusion: {in:1..100, message: "must between 1 to 100"}
  validates :email, presence:{message:"is required."}, uniqueness: {message:"is already exist."},format:{with:/@/,message:"must contain @."}
  validates :contact_no, presence:{message:"is required."},uniqueness: {message:"is already exist."},length: {is: 10,message:"must be 10 digits."}
  def self.update_reg(state,id,sr)
    print state.to_s
    user=CandidateDetail.find_by_id(id)
    user.reg_no="NZ/"+sr+"/"+state.to_s+"/"+id.to_s
    user.save
  end

end
