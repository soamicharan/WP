class FilterPageController < ApplicationController
  def filter_menu
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

      redirect_to filter_path,notice: "Please fill at least one field."
    else
      print complete_sql_query
      redirect_to candidate_details_path(:query => [complete_sql_query,param_query_list])
      

    end



  end
end
