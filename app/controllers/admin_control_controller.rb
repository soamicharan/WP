class AdminControlController < ApplicationController
  before_action :isAdmin
  def isAdmin
    unless current_user&&current_user.admin
      redirect_to candidate_details_path,notice: "You are not the Admin"
    end
  end
  def admin_panel
    @all_email=User.all
  end
  def admin_panel_create
    unless params[:password]==params[:password_confirmation]
      render "admin_panel", notice: "Password must match"
    end
  end
  def create_user
    User.create_new_user(params[:email],params[:password])
    redirect_to panel_path
  end
  def edit_user
    User.edit_user(params[:prev_email],params[:email],params[:password])
    redirect_to panel_path
  end
  def delete_user
    User.delete_user(params[:email])
    redirect_to panel_path
  end
end
