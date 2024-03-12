class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  
  def set_current_user
    if session[:user_id].present?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
    # @current_user = User.find_by(id: session[:user_id])
  end

  

end
