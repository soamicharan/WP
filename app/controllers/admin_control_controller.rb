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
    unless params[:password].length<6
      User.create_new_user(params[:email],params[:password])
      redirect_to panel_path
    else
      render panel_create_path, notice: "Password must have minimum 6 characters"
    end
  end
  def edit_user
    if User.exists?(params[:prev_email])
      User.edit_user(params[:prev_email],params[:email],params[:password])
      redirect_to panel_path,notice: "User edited successfully"
    else
      render panel_path, notice: "User previous email does not exists."
    end
  end
  def delete_user
    if User.exists?(params[:email])
      User.delete_user(params[:email])
      redirect_to panel_path,notice: "User deleted successfully"
    else
      render panel_create_path,notice: "Email does not exists"
    end
  end
end
