class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  attr_reader :current_user
  helper_method :current_user, :signed_in?

  before_action :authenticate

  def signed_in?
    current_user != nil
  end

  def authenticate
    authenticate_or_request_with_http_basic do |email, password|
      if flash[:will_logout] == true
        false
      else
        @current_user ||= User.find_by(email: email, password: password)
      end
    end
  end
end
