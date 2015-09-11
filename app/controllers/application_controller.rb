class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  attr_reader :current_user
  helper_method :current_user, :signed_in?, :beta_user?

  before_action :authenticate
  before_action :require_invitation

  def signed_in?
    current_user != nil
  end

  def authenticate
    @current_user = User.find_by(id: session[:current_user])

    redirect_to root_url if current_user.nil?
  end

  def require_invitation
    return unless Rails.env.production?

    redirect_to root_url unless beta_user?
  end

  def beta_user?
    cookies[:beta_user].present?
  end

  def beta_user!
    cookies.permanent[:beta_user] = true
  end

  def invitation_codes
    ENV["INVITATION_CODES"].to_s.split(";").compact
  end
end
