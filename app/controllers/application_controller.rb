class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :early_adopter_name

  before_action :authenticate_early_adopters if Rails.env.production?

  def current_user
    @current_user ||= User.find_by(email: session[:current_user])
  end

  def signed_in?
    current_user != nil
  end

  def early_adopter_name
    username, _ = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    username.capitalize
  end

  def authenticate_early_adopters
    early_adopters = JSON.parse ENV.fetch("EARLY_ADOPTERS")
    authenticate_or_request_with_http_basic do |username, password|
      early_adopters[username] == password
    end
  end
end
