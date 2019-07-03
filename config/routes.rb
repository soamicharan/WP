# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        candidate_details#dashboard
#          new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#              user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#             user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                           PUT    /users/password(.:format)                                                                devise/passwords#update
#                           POST   /users/password(.:format)                                                                devise/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#         user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                           PUT    /users(.:format)                                                                         devise/registrations#update
#                           DELETE /users(.:format)                                                                         devise/registrations#destroy
#                           POST   /users(.:format)                                                                         devise/registrations#create
#         candidate_details GET    /candidate_details(.:format)                                                             candidate_details#index
#                           POST   /candidate_details(.:format)                                                             candidate_details#create
#      new_candidate_detail GET    /candidate_details/new(.:format)                                                         candidate_details#new
#     edit_candidate_detail GET    /candidate_details/:id/edit(.:format)                                                    candidate_details#edit
#          candidate_detail GET    /candidate_details/:id(.:format)                                                         candidate_details#show
#                           PATCH  /candidate_details/:id(.:format)                                                         candidate_details#update
#                           PUT    /candidate_details/:id(.:format)                                                         candidate_details#update
#                           DELETE /candidate_details/:id(.:format)                                                         candidate_details#destroy
#                    filter GET    /Filter(.:format)                                                                        filter_page#filter_menu
#             filter_result POST   /Filter_Result(.:format)                                                                 candidate_details#filter_result
#                     panel GET    /Admin_Panel(.:format)                                                                   admin_control#admin_panel
#              panel_create GET    /Admin_Panel_Create(.:format)                                                            admin_control#admin_panel_create
#               Admin_Panel POST   /Admin_Panel(.:format)                                                                   admin_page#admin_panel
#                panel_edit GET    /Admin_Panel_Edit(.:format)                                                              admin_control#admin_panel_update
#              panel_delete GET    /Admin_Panel_Delete(.:format)                                                            admin_control#admin_panel_delete
#               create_user POST   /Create_User(.:format)                                                                   admin_control#create_user
#                 edit_user POST   /Edit_User(.:format)                                                                     admin_control#edit_user
#               delete_user POST   /Delete_User(.:format)                                                                   admin_control#delete_user
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  root 'candidate_details#dashboard' #root controller candidate details
  devise_for :users             #Users devise
  resources :candidate_details  #candidate_details scaffold
  #---------filter routes---------#
  get 'Filter', to: "filter_page#filter_menu", as:"filter"
  post "Filter_Result",to: "candidate_details#filter_result", as: "filter_result"
  #--------------------------------#
  #----------Admin routes----------#
  get "Admin_Panel", to: "admin_control#admin_panel", as:"panel"
  get "Admin_Panel_Create", to:"admin_control#admin_panel_create", as:"panel_create"
  post "Admin_Panel", to: "admin_page#admin_panel"
  get "Admin_Panel_Edit", to: "admin_control#admin_panel_update",as: "panel_edit"
  get "Admin_Panel_Delete", to: "admin_control#admin_panel_delete",as: "panel_delete"
  post "Create_User",to: "admin_control#create_user",as:"create_user"
  post "Edit_User", to:"admin_control#edit_user",as:"edit_user"
  post "Delete_User", to:"admin_control#delete_user",as:"delete_user"
  #--------------------------------#
end
