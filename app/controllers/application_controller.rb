class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  attr_reader :current_user
  helper_method :current_user, :signed_in?, :early_adopter_name

  before_action :authenticate

  def signed_in?
    current_user != nil
  end

  def early_adopter_name
    # TODO: place an attribute on User. e.g. User#first_name
    username, _ = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    username.capitalize
  end

  def authenticate
    authenticate_or_request_with_http_basic do |email, password|
      @current_user ||= User.find_by(email: email, password: password)
    end
  end
end
