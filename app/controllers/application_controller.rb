class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  attr_reader :current_user
  helper_method :current_user, :signed_in?

  before_action :authenticate

  def signed_in?
    current_user != nil
  end

  def authenticate
    @current_user = User.find_by(id: session[:current_user])

    redirect_to root_url if current_user.nil?
  end
end
