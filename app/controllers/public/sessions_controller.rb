# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  #before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected
  
  #この部分を見て頂いたレビューの方退会機能の部分に関して
  #アドバイスがあればDMを頂けると嬉しいです。
  #今一理解ができていません。

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password]) && is_deleted
      new_customer_registration_path
    elsif @customer.valid_password?(params[:customer][:password]) && !is_deleted
      customer_session_path
    else
      new_customer_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end