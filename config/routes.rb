Rails.application.routes.draw do
  get 'Filter', to: "filter_page#filter_menu", as:"filter"
  post "Filter_Result",to: "candidate_details#filter_result", as: "filter_result"
  root 'candidate_details#dashboard'
  resources :candidate_details
  devise_for :users
  get "download_candidate_details", to:"candidate_details#downloadxlsx", as:"download"
  get "Admin_Panel", to: "admin_control#admin_panel", as:"panel"
  get "Admin_Panel_Create", to:"admin_control#admin_panel_create", as:"panel_create"
  post "Admin_Panel", to: "admin_page#admin_panel"
  get "Admin_Panel_Edit", to: "admin_control#admin_panel_update",as: "panel_edit"
  get "Admin_Panel_Delete", to: "admin_control#admin_panel_delete",as: "panel_delete"
  post "Create_User",to: "admin_control#create_user",as:"create_user"
  post "Edit_User", to:"admin_control#edit_user",as:"edit_user"
  post "Delete_User", to:"admin_control#delete_user",as:"delete_user"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
