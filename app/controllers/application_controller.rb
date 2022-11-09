class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || posts_path
  end

  def logged_in?
    user.present?
  end

  protected

  def configure_permitted_parameters
    attributes = %i[first_name last_name username prof_pic email password password_confirmation]
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:update, keys: [:username])
  end
end
