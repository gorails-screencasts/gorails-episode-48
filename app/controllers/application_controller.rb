class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_account

  def require_account!
    redirect_to root_url(subdomain: "www") if !@account.present?
  end

  def set_account
    @account = Account.find_by(subdomain: request.subdomain)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:email, :password, :password_confirmation, account_attributes: [:subdomain])
    }
  end
end
