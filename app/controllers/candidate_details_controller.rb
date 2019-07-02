class CandidateDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_candidate_detail, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:query].nil?
	params[:query]="SELECT * FROM candidate_details"
    end
    @candidate_details = CandidateDetail.find_by_sql(params[:query])
  end
  def dashboard
    
    redirect_to candidate_details_path(:query => "SELECT * FROM candidate_details WHERE")
  end
  def filter_result
   param_list=[:src_reg,:zone,:name,:branch,:state,:status]
    param_string=["src_reg","zone","name","branch","state","status"]
    param_query_list=[]
    param_query=""
    for i in (0..5)
      unless params[param_list[i]].blank?
        param_query_list.push(params[param_list[i]])
        param_query+=param_string[i]+"= ? AND "
      end
    end
    unless params[:DOR].blank?
	st_date,end_date=params[:DOR].split(' - ')
        param_query+='("DOR" BETWEEN ? AND ?) AND '
	param_query_list.push(st_date,end_date)
       
    end
    unless params[:DOC].blank?
	st_date,end_date=params[:DOC].split(' - ')
        param_query+='("DOC" BETWEEN ? AND ?) AND '
	param_query_list.push(st_date,end_date)
    end
    
    complete_sql_query="SELECT * FROM candidate_details WHERE "+param_query[0..param_query.length-5]+" ;"
    print complete_sql_query
    if param_query==""
      redirect_to candidate_details_path(:query => "SELECT * FROM candidate_details"),notice: "Please fill at least one field."
    else
      print complete_sql_query
      redirect_to candidate_details_path(:query => [complete_sql_query,param_query_list])
    end

  end
  def show
  end
  def new
    @candidate_detail = CandidateDetail.new
  end
  def edit
  end
  def create
    @state_hash={
    "AP":"Andhra Pradesh",
    "AR":"Arunachal Pradesh",
    "AS":"Assam",
    "BR":"Bihar",
    "CG":"Chhattisgarh",
    "Chandigarh":"Chandigarh",
    "DN":"Dadra and Nagar Haveli",
    "DD":"Daman and Diu",
    "DL":"Delhi",
    "GA":"Goa",
    "GJ":"Gujarat",
    "HR":"Haryana",
    "HP":"Himachal Pradesh",
    "JK":"Jammu and Kashmir",
    "JH":"Jharkhand",
    "KA":"Karnataka",
    "KL":"Kerala",
    "MP":"Madhya Pradesh",
    "MH":"Maharashtra",
    "MN":"Manipur",
    "ML":"Meghalaya",
    "MZ":"Mizoram",
    "NL":"Nagaland",
    "OR":"Orissa",
    "PB":"Punjab",
    "PY":"Pondicherry",
    "RJ":"Rajasthan",
    "SK":"Sikkim",
    "TN":"Tamil Nadu",
    "TR":"Tripura",
    "UP":"Uttar Pradesh",
    "UK":"Uttarakhand",
    "WB":"West Bengal"
  }
    @candidate_detail = CandidateDetail.new(candidate_detail_params)
    @candidate_detail.src_reg='R/'+@state_hash.key(@candidate_detail.state).to_s
    respond_to do |format|
      if @candidate_detail.save
        @candidate_detail.update(s_no: @candidate_detail.id)
        @candidate_detail.update(reg_no: 'NZ/'+@candidate_detail.src_reg+"/"+@candidate_detail.id.to_s)
        format.html { redirect_to @candidate_detail, notice: 'Candidate detail was successfully created.' }
        format.json { render :show, status: :created, location: @candidate_detail }
      else
        format.html { render :new }
        format.json { render json: @candidate_detail.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    @state_hash={
        "AP":"Andhra Pradesh",
        "AR":"Arunachal Pradesh",
        "AS":"Assam",
        "BR":"Bihar",
        "CG":"Chhattisgarh",
        "Chandigarh":"Chandigarh",
        "DN":"Dadra and Nagar Haveli",
        "DD":"Daman and Diu",
        "DL":"Delhi",
        "GA":"Goa",
        "GJ":"Gujarat",
        "HR":"Haryana",
        "HP":"Himachal Pradesh",
        "JK":"Jammu and Kashmir",
        "JH":"Jharkhand",
        "KA":"Karnataka",
        "KL":"Kerala",
        "MP":"Madhya Pradesh",
        "MH":"Maharashtra",
        "MN":"Manipur",
        "ML":"Meghalaya",
        "MZ":"Mizoram",
        "NL":"Nagaland",
        "OR":"Orissa",
        "PB":"Punjab",
        "PY":"Pondicherry",
        "RJ":"Rajasthan",
        "SK":"Sikkim",
        "TN":"Tamil Nadu",
        "TR":"Tripura",
        "UP":"Uttar Pradesh",
        "UK":"Uttarakhand",
        "WB":"West Bengal"
    }
    respond_to do |format|
      if @candidate_detail.update(candidate_detail_params)
        CandidateDetail.update_reg(@state_hash.key(@candidate_detail.state),@candidate_detail.id)
        format.html { redirect_to @candidate_detail, notice: 'Candidate details was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate_detail }
      else
        format.html { render :edit }
        format.json { render json: @candidate_detail.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @candidate_detail.destroy
    respond_to do |format|
      format.html { redirect_to candidate_details_url, notice: 'Candidate details was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  private
    def set_candidate_detail
      @candidate_detail = CandidateDetail.find(params[:id])
    end
    def candidate_detail_params
      params.require(:candidate_detail).permit(:s_no, :src_reg, :zone, :DOR, :reg_no, :name, :gender, :age, :address, :branch, :email, :contact_no, :state, :qualification, :specialization, :experience, :remarks_mobility, :DOC, :status)
    end
end
