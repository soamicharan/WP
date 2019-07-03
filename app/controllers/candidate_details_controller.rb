class CandidateDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_candidate_detail, only: [:show, :edit, :update, :destroy]
  def self.state_hash
    {
    "AP":"Andhra Pradesh",
    "AR":"Arunachal Pradesh",
    "AS":"Assam",
    "BR":"Bihar",
    "CG":"Chhattisgarh",
    "CH":"Chandigarh",
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
end
  def index
    if !params[:sort].nil? 
      if params[:q].nil?
        @candidate_details=CandidateDetail.all
        if params[:type]=="DESC"
          @candidate_details=@candidate_details.sort_by(&params[:sort].to_sym).reverse
        else
          @candidate_details=@candidate_details.sort_by(&params[:sort].to_sym)
        end
      else
        temp=params[:q]
      text=temp[0]
      salt, data = text.split "$$"
      len   = ActiveSupport::MessageEncryptor.key_len
      key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new key
      decrypt_query = crypt.decrypt_and_verify(data)
        @candidate_details = CandidateDetail.find_by_sql([decrypt_query,temp[1]])
        @qur=params[:q]
        if params[:type]=="DESC"
          @candidate_details=@candidate_details.sort_by(&params[:sort].to_sym).reverse
        else
          @candidate_details=@candidate_details.sort_by(&params[:sort].to_sym)
        end
      end
    elsif !params[:query].nil?
      temp=params[:query]
      text=temp[0]
      salt, data = text.split "$$"
      len   = ActiveSupport::MessageEncryptor.key_len
      key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new key
      decrypt_query = crypt.decrypt_and_verify(data)

      @candidate_details = CandidateDetail.find_by_sql([decrypt_query,temp[1]])
      @qur=params[:query]
    else 
      @candidate_details=CandidateDetail.all
    end
    respond_to do |format|
      format.html
      format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="candidates.xlsx"'}  
    end
    
  end
  def dashboard
    redirect_to candidate_details_path
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
    unless params[:custom_day].blank?
	    stdays=0
	    enddays=0
      if params[:custom_day]=="Greater than 365 days"
        now=Date.today
        now=now-365
        param_query+='("DOR" <= ?) AND '
        param_query_list.push(now)
      elsif params[:custom_day]=="Between 180 to 365 days"
        now=Date.today
        st=now-180
        en=now-365
        param_query+='("DOR" BETWEEN ? AND ?) AND '
        param_query_list.push(en,st)
      elsif params[:custom_day]=="Between 60 to 180 days"
        now=Date.today
        st=now-60
        en=now-180
        param_query+='("DOR" BETWEEN ? AND ?) AND '
        param_query_list.push(en,st)
      else
        now=Date.today
        now=now-60
        param_query+='("DOR" >= ?) AND '
        param_query_list.push(now)
      end
    end
    complete_sql_query="SELECT * FROM candidate_details WHERE "+param_query[0..param_query.length-5]+" ;"
    if param_query==""
      redirect_to candidate_details_path,notice: "Please fill at least one field."
    else
      len   = ActiveSupport::MessageEncryptor.key_len
      salt  = SecureRandom.hex len
      key   = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new key
      enc_query = crypt.encrypt_and_sign(complete_sql_query)
      enc_query="#{salt}$$#{enc_query}"
      redirect_to candidate_details_path(:query => [enc_query,param_query_list])
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
    @candidate_detail = CandidateDetail.new(candidate_detail_params)
    respond_to do |format|
      if @candidate_detail.save
        @candidate_detail.update(s_no: @candidate_detail.id)
        @candidate_detail.update(reg_no: "NZ/"+@candidate_detail.src_reg+"/"+CandidateDetailsController.state_hash.key(@candidate_detail.state).to_s+"/"+@candidate_detail.id.to_s)
        format.html { redirect_to @candidate_detail, notice: 'Candidate detail was successfully created.' }
        format.json { render :show, status: :created, location: @candidate_detail }
      else
        format.html { render :new }
        format.json { render json: @candidate_detail.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @candidate_detail.update(candidate_detail_params)
        @candidate_detail.update(reg_no: "NZ/"+@candidate_detail.src_reg+"/"+CandidateDetailsController.state_hash.key(@candidate_detail.state).to_s+"/"+@candidate_detail.id.to_s)
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
