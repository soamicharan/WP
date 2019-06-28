class CandidateDetail < ApplicationRecord

  validates :name, presence:{message:"must specified."}
  validates :gender, presence:{message:"must specified."}
  validates :gender, presence:true, inclusion: { in: ["Male", "Female"], message: 'Only male and female allowed' }
  validates :age, presence: {message:"must specified."}
  validates :email, presence:{message:"is required."}, uniqueness: {message:"is already exist."},format:{with:/@/,message:"Email must contain @."}
  validates :contact_no, presence:{message:"is required."},uniqueness: {message:"is already exist."},length: {is: 10,message:"must be 10 digits."}
  
  def self.filter_result(sql_statement,parameter)
    user=CandidateDetail.find_by_sql([sql_statement,parameter])
    return user
  end
  def self.filter_count(sql_statement,parameter)
    user=CandidateDetail.find_by_sql([sql_statement,parameter])
    return user.count
  end
  def self.update_reg(state,id)
    print state.to_s
    user=CandidateDetail.find_by_id(id)
    user.src_reg="R/"+state.to_s
    user.reg_no="NZ/R/"+state.to_s+"/"+id.to_s
    user.save

  end

end
