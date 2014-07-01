class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    session[:current_user]
  end

  def signed_in?
    current_user != nil
  end
end
