class ApplicationController < ActionController::Base
 # binding.b
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  

  

end
