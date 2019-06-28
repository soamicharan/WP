class FilterPageController < ApplicationController
  def filter_menu
  end

  def filter_result
    param_list=[:s_no,:src_reg,:zone,:DOR,:reg_no,:name,:gender,:age,:address,:branch,:email,:contact_no,:state,:qualification,:specialization,:experience,:remarks_mobility,:DOC,:status]
    param_string=["s_no","src_reg","zone","DOR","reg_no","name","gender","age","address","branch","email","contact_no","state","qualification","specialization","experience","remarks_mobility","DOC","status"]
    param_query_list=[]
    param_query=""
    for i in (0..18)
      unless params[param_list[i]].blank?
        param_query_list.push(params[param_list[i]])
        param_query+=param_string[i]+"= ? and "
      end
    end
    complete_sql_query="SELECT * FROM candidate_details WHERE "+param_query[0..param_query.length-5]+" ;"
    print complete_sql_query
    if param_query==""

      redirect_to filter_path,notice: "Please fill at least one field."
    else
      @filter_result=CandidateDetail.filter_result(complete_sql_query,param_query_list)
      @filter_count=CandidateDetail.filter_count(complete_sql_query,param_query_list)

    end



  end
end
