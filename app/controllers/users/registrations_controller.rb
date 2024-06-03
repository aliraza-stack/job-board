# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :build_user_detail, only: [:edit]
  before_action :build_address, only: [:edit]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  def create
    build_resource(sign_up_params)
    resource.role = params[:user][:role]
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :first_name, :last_name, :profession, :bio])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:current_password, :role, :avatar, user_detail_attributes: [:first_name, :last_name, :profession, :bio, :birthday, :gender, :phone_number, :website, :id], address_attributes: [:id, :street_address, :city, :state, :zip_code, :country]])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end
  # def after_sign_in_path_for(resource)
  #   if resource.admin?
  #     admin_dashboard_path
  #   elsif resource.employer?
  #     employer_dashboard_path
  #   elsif resource.freelancer?
  #     freelancer_dashboard_path
  #   else
  #     root_path
  #   end
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def build_user_detail
    resource.build_user_detail unless resource.user_detail
  end

  def build_address
    resource.build_address unless resource.address
  end
end
